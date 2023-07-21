Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5890575BCD3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 05:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjGUDcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 23:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGUDcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 23:32:10 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916871726
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 20:32:09 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R6ZqW1LzmzBRDtM
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 11:32:07 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689910327; x=1692502328; bh=DgngVkhS4Y2EpAg4Rz03E9/o90m
        U59SYiP+mSo3EkDk=; b=L92kgOZBjYxTAwTQMpz91K3P04x5FIHueeyz09mIhMH
        H2DAXpE9oaPeNeswRrcoTz+sRb5TuyVYRLwC0seqzyIyizXUVkrbpsU2rzMcZefm
        WhTozeLPQ+U31bhe+zPmc7JpPwAWTcCtCtwBFNlhDMHr67+SL6PKZhvtwIU3IN3o
        UtzXYA9w1ilXdcIFpDyAvf1/MQBarZBawBr0xrIakCHU4aA71Htd5XN9M1zk8Ew4
        r2i0U8JRSE5BN03n5JLjlTCCiXVCsSs5yBl2uUgwLvCN3k40ZVMVEDuxwqFsEBtJ
        gMM9m3jHEAbnMamkMsm2PTREL/mgTaIllwNQg/qYA/g==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xKi8Zvp4_Syj for <linux-kernel@vger.kernel.org>;
        Fri, 21 Jul 2023 11:32:07 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R6ZqV5jSmzBRDrd;
        Fri, 21 Jul 2023 11:32:06 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 21 Jul 2023 11:32:06 +0800
From:   sunran001@208suo.com
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: open brace '{' following struct go on the same
 line
In-Reply-To: <20230721033048.4840-1-xujianghui@cdjrlc.com>
References: <20230721033048.4840-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <d0906df99cdf6f76220e298bebaa5029@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ERROR: open brace '{' following struct go on the same line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h | 3 +--
  1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h 
b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
index 52045ad59bed..eec816f0cbf9 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
@@ -24,8 +24,7 @@
  #ifndef __AMDGPU_PM_H__
  #define __AMDGPU_PM_H__

-struct cg_flag_name
-{
+struct cg_flag_name {
  	u64 flag;
  	const char *name;
  };
