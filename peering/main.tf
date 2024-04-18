resource "aws_vpc_peering_connection" "peer" {
  for_each = { for idx, vpc in var.vpc_peering_connections : idx => vpc }

  vpc_id          = each.value.requester_vpc_id
  peer_vpc_id     = each.value.accepter_vpc_id
  peer_owner_id   = each.value.accepter_account_id
  auto_accept     = false

  tags = {
    Name = "Peering between ${each.value.requester_vpc_id} and ${each.value.accepter_vpc_id}"
  }
}

resource "aws_vpc_peering_connection_accepter" "peer_accepter" {
  for_each = { for idx, vpc in var.vpc_peering_connections : idx => vpc if vpc.auto_accept }

  vpc_peering_connection_id = aws_vpc_peering_connection.peer[each.key].id
  auto_accept               = true

  tags = {
    Name = "Accepter for ${each.value.requester_vpc_id} to ${each.value.accepter_vpc_id}"
  }

  depends_on = [
    aws_vpc_peering_connection.peer
  ]
}
