Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3866175BBCF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 03:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjGUBbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 21:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGUBbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 21:31:17 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14701FED
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 18:31:14 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R6X7z1gltzBRDtF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:31:11 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689903071; x=1692495072; bh=Qq62sLIO6ROPq/epkdPBhc/KPvU
        UIj4lTk/QHIBHckU=; b=exwDGHjJyLXPDiDr6d+fWHA6TZFDscQnhyPw0gAKMcn
        ZK2aQi075XlBAWPyQwPHF5709F6h4hF7SJrR3cYlt+z0V8nKkof/6FJL+E91qyBu
        gaqTe8ZEjZD5x3GrJC+kbm9wnexxiC4QOF3loVsjh/4HFyAWuaiOt56AFfwInDJi
        6awS4gwxcSDqh3jZ2gCvHvy+Ev+DWSgeJtJjsjBAlL0kWsgZGFo5mX/THZVgNxyl
        dILNLnECjUvJ79B088rGON54PE4tIRcvzqRxF777cZKUISW/YIwGynOSvt8xJgjM
        heDtXdKRJdrKJklUyBDzKeJnbvCyS7Dg64kPzhvfbwA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id J0GRzkBL_g70 for <linux-kernel@vger.kernel.org>;
        Fri, 21 Jul 2023 09:31:11 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R6X7y5n73zBJkk9;
        Fri, 21 Jul 2023 09:31:10 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 21 Jul 2023 09:31:10 +0800
From:   sunran001@208suo.com
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd: open brace '{' following struct go on the same line
In-Reply-To: <20230721012635.4552-1-xujianghui@cdjrlc.com>
References: <20230721012635.4552-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <f9f0077b8f91d858777e9ad2db972db8@208suo.com>
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

Fix the checkpatch error as open brace '{' following struct should
go on the same line.

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/amd/include/yellow_carp_offset.h | 6 ++----
  1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/yellow_carp_offset.h 
b/drivers/gpu/drm/amd/include/yellow_carp_offset.h
index 0fea6a746611..a2c8dca2425e 100644
--- a/drivers/gpu/drm/amd/include/yellow_carp_offset.h
+++ b/drivers/gpu/drm/amd/include/yellow_carp_offset.h
@@ -7,13 +7,11 @@
  #define MAX_SEGMENT                                         6


-struct IP_BASE_INSTANCE
-{
+struct IP_BASE_INSTANCE {
      unsigned int segment[MAX_SEGMENT];
  } __maybe_unused;

-struct IP_BASE
-{
+struct IP_BASE {
      struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
  } __maybe_unused;
