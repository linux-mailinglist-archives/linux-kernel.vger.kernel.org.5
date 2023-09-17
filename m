Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C027A7A3670
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 17:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbjIQPdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 11:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237154AbjIQPdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 11:33:00 -0400
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3EA173C;
        Sun, 17 Sep 2023 08:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8pjl.ca;
        s=protonmail2; t=1694964617; x=1695223817;
        bh=14a9JoTKwLBMDvvPJuVuwcY6tE34u5ZiJcBdjh1EBjs=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=s3TKwkmP5NMSXdFWXqh9NdWO5SVB0dgZaLDt2OO+ojJ/vDgcPXGJk4R3p9RCtLc5U
         v6vi3Q37GVzkrKkxlpSut4qpHKC1zlGQRlSVgZdN+S4t83YCjX5T8raqpyI9aWaOQ+
         dq8A2VlrGI/wPlL2NJe2/z9c39k6CIuQMUJDhlCGr1IN5Nx6YAV/oVqGA4w61FZi+q
         p/vv8smcLI5XHAobznuoDIWxMTzhL5W/HzKKVNh5j+x8fkyq6ek26ge2KYO0QIGQa3
         zk07gdfVADnMU+0lfUmGY5NONvLrF9O8Rk2qKcA4U/a8jth+5POby6pKyDB9QsvwM3
         NKyEQ/BAY+W6w==
Date:   Sun, 17 Sep 2023 15:30:10 +0000
To:     linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Peter Lafreniere <peter@n8pjl.ca>
Cc:     Peter Lafreniere <peter@n8pjl.ca>, thomas@osterried.de,
        ralf@linux-mips.org, netdev@vger.kernel.org
Subject: [PATCH 2/3] MAINTAINERS: Update link for linux-ax25.org
Message-ID: <20230917152938.8231-3-peter@n8pjl.ca>
In-Reply-To: <20230917152938.8231-1-peter@n8pjl.ca>
References: <20230908113907.25053-1-peter@n8pjl.ca> <20230917152938.8231-1-peter@n8pjl.ca>
Feedback-ID: 53133685:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

http://linux-ax25.org has been down for nearly a year. Its official
replacement is https://linux-ax25.in-berlin.de. Update all links to the
new URL.

Link: https://marc.info/?m=3D166792551600315
Signed-off-by: Peter Lafreniere <peter@n8pjl.ca>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a62f5a2a1c9e..1c52b7ddc2cc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3344,7 +3344,7 @@ AX.25 NETWORK LAYER
 M:=09Ralf Baechle <ralf@linux-mips.org>
 L:=09linux-hams@vger.kernel.org
 S:=09Maintained
-W:=09http://www.linux-ax25.org/
+W:=09https://linux-ax25.in-berlin.de
 F:=09include/net/ax25.h
 F:=09include/uapi/linux/ax25.h
 F:=09net/ax25/
@@ -14749,7 +14749,7 @@ NETROM NETWORK LAYER
 M:=09Ralf Baechle <ralf@linux-mips.org>
 L:=09linux-hams@vger.kernel.org
 S:=09Maintained
-W:=09http://www.linux-ax25.org/
+W:=09https://linux-ax25.in-berlin.de
 F:=09include/net/netrom.h
 F:=09include/uapi/linux/netrom.h
 F:=09net/netrom/
@@ -18598,7 +18598,7 @@ ROSE NETWORK LAYER
 M:=09Ralf Baechle <ralf@linux-mips.org>
 L:=09linux-hams@vger.kernel.org
 S:=09Maintained
-W:=09http://www.linux-ax25.org/
+W:=09https://linux-ax25.in-berlin.de
 F:=09include/net/rose.h
 F:=09include/uapi/linux/rose.h
 F:=09net/rose/
--=20
2.42.0


