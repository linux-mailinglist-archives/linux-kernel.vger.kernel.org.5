Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C957516A0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 05:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjGMDL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 23:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjGMDLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 23:11:24 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE5E1BD7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 20:11:23 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R1flC00rLzBJBXT
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 11:11:18 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689217878; x=1691809879; bh=nwNP2MyNrAdRHJfIy7eTE9fTnt0
        LobDKQvEr5pDGzFw=; b=MagLv5jGyfWJM+2hnpM9R496CqzC+uP2Kh+DrS8juMD
        F1Ojvzez/GjxgpHrDEXvEz1NqiLlCL0g3BPvNoUG9lunGylgGOyGih1gTN9j4f/u
        Pe7IRnoh+siAEPIh06I2luTcyrWab7zqLLKOIvtrxs9Qv7z8L8reHxf/Z6vgJnya
        znMio0V4Blrx+LzIfVQft3Nk/Ulx1MX2Z1fw22xRp9Ct9rw37bCBEXMuNWiuyDm4
        4zmCLdDNhjaUXLVYhbIB4IrZRIvKBr+RiKetxNT2yFaB7+Jx30zRodxSAsvKA7Zt
        8JpOShmh5rgGwGm9IMv7PinTY4SRx5sK0zEbpxh9S4g==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tYdzRxWltnoS for <linux-kernel@vger.kernel.org>;
        Thu, 13 Jul 2023 11:11:18 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R1flB4LZzzBHXgf;
        Thu, 13 Jul 2023 11:11:18 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 13 Jul 2023 11:11:18 +0800
From:   liubin001@208suo.com
To:     airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Fwd: [PATCH] drm/vmwgfx: "foo* const bar" should be "foo * const
 bar"\ that ope- n brace { should be on the previous line
In-Reply-To: <tencent_4F166AB6DC9C757B0454E3F4875027411F08@qq.com>
References: <tencent_4F166AB6DC9C757B0454E3F4875027411F08@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <7d2a5aba980cd6b7928c15e65fd94086@208suo.com>
X-Sender: liubin001@208suo.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-------- =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6 --------

  		=E4=B8=BB=E9=A2=98:
  		[PATCH] drm/vmwgfx: "foo* const bar" should be "foo * const bar"\=20
that ope- n brace { should be on the previous line

  		=E6=97=A5=E6=9C=9F:
  		2023-07-13 10:44

  		=E5=8F=91=E4=BB=B6=E4=BA=BA:
  		fujie <2459483872@qq.com>

  		=E6=94=B6=E4=BB=B6=E4=BA=BA:
  		liubin001@208suo.com

  		=E6=8A=84=E9=80=81:
  		fujie <2459483872@qq.com>

(1)The standard format for declaring a pointer is to add a space bet-
ween the type name and the * symbol, as well as between the * symbol and=20
the variable name.
(2) that open brace { should be on the previous line
Signed-off-by: fujie <2459483872@qq.com>
---
  drivers/gpu/drm/vmwgfx/vmwgfx_msg.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c=20
b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
index 96504a320c2a..b56936f95d31 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
@@ -87,7 +87,7 @@ struct rpc_channel {

  #if IS_ENABLED(CONFIG_DRM_VMWGFX_MKSSTATS)
  /* Kernel mksGuestStats counter names and desciptions; same order as=20
enum mksstat_kern_stats_t */
-static const char* const mksstat_kern_name_desc[MKSSTAT_KERN_COUNT][2]=20
=3D
{
         { "vmw_execbuf_ioctl", "vmw_execbuf_ioctl" },
         { "vmw_cotable_resize", "vmw_cotable_resize" },
};

+static const char * const mksstat_kern_name_desc[MKSSTAT_KERN_COUNT][2]=20
=3D {
      { "vmw_execbuf_ioctl", "vmw_execbuf_ioctl" },
      { "vmw_cotable_resize", "vmw_cotable_resize" },
  };
