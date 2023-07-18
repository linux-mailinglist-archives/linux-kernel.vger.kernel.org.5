Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3C77581FB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjGRQWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjGRQWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:22:31 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B893010F5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:22:29 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R543j6H3RzBR1P3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:22:25 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689697345; x=1692289346; bh=0AwYdL/qs2d228NpsTavi5Y4Ssh
        iw3reROCWttoiY98=; b=gfmOHYXbjNbBUoiqbXdfr5HjZPAaGwQIVJPS5Zol565
        8ilhZ4NEtnqFr0VrxMOwVfOf07837pXqM3j3A0bZng//oCuSsJnZMwDXSSurCQXT
        VIqqxysZLp3qv/Ak2rRK2RkWgRWuLGvSpYKL99n1x5aGa6DKiN73B4CvnJGyvd05
        iklVJfRJZ3yTlCWFXC3hfY7g9vN3wzFerZhmQiX7/31w3znU1OEVPq5dPwsCZT2f
        kCM7oBFWK/ksiNOgyT52AKzicE9OuCwIndw3XuH1fFymyKMe/7j/em2vTuVifdfy
        SFQi98VYBJGQ9obGP0TunHbEupi3D18AKKdm+/Naoww==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Hw47CF8gFG6l for <linux-kernel@vger.kernel.org>;
        Wed, 19 Jul 2023 00:22:25 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R543j22dLzBQskk;
        Wed, 19 Jul 2023 00:22:25 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 00:22:25 +0800
From:   pangzizhen001@208suo.com
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/tty: Fix typos in comments
In-Reply-To: <20230718162025.64358-1-wangjianli@cdjrlc.com>
References: <20230718162025.64358-1-wangjianli@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <ffa4ee5ba65722fe52481638ab20e068@208suo.com>
X-Sender: pangzizhen001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete duplicate word "the"

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
  drivers/tty/n_gsm.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index b411a26cc092..e8cd1e07eafe 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1148,7 +1148,7 @@ static void __gsm_data_queue(struct gsm_dlci 
*dlci, struct gsm_msg *msg)
   *
   *    Add data to the transmit queue and try and get stuff moving
   *    out of the mux tty if not already doing so. Take the
- *    the gsm tx lock and dlci lock.
+ *    gsm tx lock and dlci lock.
   */

  static void gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
