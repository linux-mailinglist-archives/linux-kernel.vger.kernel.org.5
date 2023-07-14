Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A357752FE0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbjGNDUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbjGNDUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:20:53 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E121B5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 20:20:51 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2Gvg6TFHzBRSVY
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 11:20:47 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689304847; x=1691896848; bh=4RThHj/DNsNyooB75oPh9gIzWA4
        yeEuFdFd3SjfPcMY=; b=xbbO6lOgpFwD/BA1IFiZVSZDjHtlJSe9RMNxTkie6D9
        yU19LkyjYjax75jtvCX/ukSR8nupYhmz73JowPy7Y9HpgwTxvrc7k/5gRrGqdYml
        okGjarGNTNipRvqbWzqXy0hmwCOKGfRa2C5n2rfHEj1nlf/xXshg3egeOuhujlTY
        171xj6+ajhU0z4wqn+GOQZbxhclll25GXm/JUchqMzYmAs4VyJryaW71SxYmXjd0
        21eGWKUtZcpLXaShyOz3er0/UVS5X573SoKij3/4WTJIrIOtEYFFlO6DISkSUZnj
        Yf0aqfBgy2y6cl5jJ9AuFd4RD681IsP4boe8WUzi4TQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CFTrLuV3HVAY for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 11:20:47 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2Gvg3pGGzBJk54;
        Fri, 14 Jul 2023 11:20:47 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 11:20:47 +0800
From:   shijie001@208suo.com
To:     airlied@gmail.com, daniel@ffwll.ch, christian.koenig@amd.com,
        alexander.deucher@amd.com, Xinhui.Pan@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon: ERROR: open brace '{' following function
 definitions go on the next line
In-Reply-To: <tencent_21616D4FB2F221FE67B71858B197C646AB08@qq.com>
References: <tencent_21616D4FB2F221FE67B71858B197C646AB08@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <50bf0cff1b048f24484f32ff0e5015f6@208suo.com>
X-Sender: shijie001@208suo.com
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

Fix four occurrences of the checkpatch.pl error:
ERROR: open brace '{' following function definitions go on the next line

Signed-off-by: Jie Shi <shijie001@208suo.com>
---
  drivers/gpu/drm/radeon/radeon_atpx_handler.c | 12 ++++++++----
  1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_atpx_handler.c 
b/drivers/gpu/drm/radeon/radeon_atpx_handler.c
index 6f93f54bf651..2a3c3f8b02e2 100644
--- a/drivers/gpu/drm/radeon/radeon_atpx_handler.c
+++ b/drivers/gpu/drm/radeon/radeon_atpx_handler.c
@@ -61,19 +61,23 @@ struct atpx_mux {
      u16 mux;
  } __packed;

-bool radeon_has_atpx(void) {
+bool radeon_has_atpx(void)
+{
      return radeon_atpx_priv.atpx_detected;
  }

-bool radeon_has_atpx_dgpu_power_cntl(void) {
+bool radeon_has_atpx_dgpu_power_cntl(void)
+{
      return radeon_atpx_priv.atpx.functions.power_cntl;
  }

-bool radeon_is_atpx_hybrid(void) {
+bool radeon_is_atpx_hybrid(void)
+{
      return radeon_atpx_priv.atpx.is_hybrid;
  }

-bool radeon_atpx_dgpu_req_power_for_displays(void) {
+bool radeon_atpx_dgpu_req_power_for_displays(void)
+{
      return radeon_atpx_priv.atpx.dgpu_req_power_for_displays;
  }
