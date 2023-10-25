Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FBF7D6182
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 08:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjJYGRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 02:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJYGRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 02:17:06 -0400
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0791DA;
        Tue, 24 Oct 2023 23:17:03 -0700 (PDT)
Received: from unicom145.biz-email.net
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id UGP00158;
        Wed, 25 Oct 2023 14:16:58 +0800
Received: from localhost.localdomain.com (10.73.46.69) by
 jtjnmail201619.home.langchao.com (10.100.2.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 14:16:57 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <steffen.klassert@secunet.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] net: ipv6: fix typo in comments
Date:   Wed, 25 Oct 2023 02:16:56 -0400
Message-ID: <20231025061656.2149-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.73.46.69]
X-ClientProxiedBy: Jtjnmail201614.home.langchao.com (10.100.2.14) To
 jtjnmail201619.home.langchao.com (10.100.2.19)
tUid:   20231025141658230116b21a149a2be55e935bab62d149
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The word "advertize" should be replaced by "advertise".

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 net/ipv6/esp6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index e023d29e919c..2cc1a45742d8 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -833,7 +833,7 @@ int esp6_input_done2(struct sk_buff *skb, int err)
 
 		/*
 		 * 1) if the NAT-T peer's IP or port changed then
-		 *    advertize the change to the keying daemon.
+		 *    advertise the change to the keying daemon.
 		 *    This is an inbound SA, so just compare
 		 *    SRC ports.
 		 */
-- 
2.31.1

