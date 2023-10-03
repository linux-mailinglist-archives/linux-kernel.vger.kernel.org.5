Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE127B5E78
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 03:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238935AbjJCBNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 21:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjJCBNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 21:13:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E26BB8
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 18:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=CHSPuipCmNpy2ogfW/tDAVS/hQDi8Lu37X0Wm8Ngz7w=; b=hEUPAPl/tOzE1PYBBFgCT1PWyz
        D4IWdVLafWo4SyOJP9SFiU0nxktzZtvGLZ/YZLU8NFzZAzuZ8XJxew0xxj9ulabBdarMyG4iDi20J
        OJ1EZw75y+LNH4bVYmhkOUUWhh5GGHXRPdCYhMrEV2GqH0GPxSnhkgjpYvbNXXaAHoXSlbqXvJCo6
        Di39v4mzG55yoplKry9ue3F+zzaiE0KQbG+2naqwDEc101uXWojZL2LvGrx59toATGY/u2RU6spqx
        zwU5OFCZpOporBAFJRYUvbN7K0GgRbG6hmHt1mB20sFGFH9GWqbdKuF4SB3iGTmevERr+JjLkzctn
        hOSjJfWg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qnTyw-00DcHx-2p;
        Tue, 03 Oct 2023 01:13:50 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/3] drm/uapi: drm_mode: fix doc typos
Date:   Mon,  2 Oct 2023 18:13:47 -0700
Message-ID: <20231003011349.27593-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct grammar (add s for plural, insert "the").

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
---
 include/uapi/drm/drm_mode.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -- a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -36,10 +36,10 @@ extern "C" {
 /**
  * DOC: overview
  *
- * DRM exposes many UAPI and structure definition to have a consistent
- * and standardized interface with user.
+ * DRM exposes many UAPI and structure definitions to have a consistent
+ * and standardized interface with the user.
  * Userspace can refer to these structure definitions and UAPI formats
- * to communicate to driver
+ * to communicate to the driver.
  */
 
 #define DRM_CONNECTOR_NAME_LEN	32
