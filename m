Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B66757601
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjGRH7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjGRH7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:59:04 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6D41BCF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:58:12 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4rsJ1QhlzBQslf
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:57:40 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689667060; x=1692259061; bh=F3ZW2q8aUdSKFjVWlHc1d6JpFpE
        4kjo8ZUXaa7+Gqhk=; b=HAeB66wM2N4XB42y8VRNegYGToxU5dpFJ9il45Yr8xY
        mv8aQUfEfZob+EmZlZi4kwhflP5I+NyLN3D6ruFJTgNX9VYfq8yoNkTN7xeEPqYZ
        FbCZfCUCrseDBebveYpVQ5+CAzIxlSio+yOLm8bkenYh3VQejxWbwFqYfNYH1my/
        94QNtwgGKvXSQ5GwW25IgIqOAmFr8QJ5NVqVlEFomX3ZR+aVcjE83+V5kdq/ibK6
        d7eFGrs1dZq5nS4T6A015KwZvsIWMOrqZi1JSFlUCiLiyP90fUJDcgaFJgLCyvC7
        jtdsuhXsPlW6e9nHlQf0MLL9nWguO4bU35NmTBkfD6g==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4YGBgoKawOk0 for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jul 2023 15:57:40 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4rsH6xKmzBJDj9;
        Tue, 18 Jul 2023 15:57:39 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 15:57:39 +0800
From:   hanyu001@208suo.com
To:     dlemoal@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: ata: pata_parport: epat.c Added missing spaces
In-Reply-To: <tencent_DAE8C1D6AAA3633E096977B14E5133F42705@qq.com>
References: <tencent_DAE8C1D6AAA3633E096977B14E5133F42705@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <5a75c59282fbe38bc4637c95c66f9151@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added spaces needed in the proper places to address:

./drivers/ata/pata_parport/epat.c:283: ERROR: spaces required around 
that '=' (ctx:VxV)
./drivers/ata/pata_parport/epat.c:283: ERROR: space required after that 
';' (ctx:VxV)
./drivers/ata/pata_parport/epat.c:283: ERROR: spaces required around 
that '<' (ctx:VxV)
./drivers/ata/pata_parport/epat.c:283: ERROR: space required after that 
';' (ctx:VxV)

Signed-off-by: Yu Han <hanyu001@208suo.com>
---
  drivers/ata/pata_parport/epat.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_parport/epat.c 
b/drivers/ata/pata_parport/epat.c
index 016bd96..efc18e2 100644
--- a/drivers/ata/pata_parport/epat.c
+++ b/drivers/ata/pata_parport/epat.c
@@ -280,7 +280,7 @@ static int epat_test_proto(struct pi_adapter *pi)
      epat_disconnect(pi);

      epat_connect(pi);
-    for (j=0;j<2;j++) {
+    for (j = 0; j < 2; j++) {
          WRi(6, 0xa0 + j * 0x10);
          for (k = 0; k < 256; k++) {
              WRi(2, k ^ 0xaa);
