Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E23E7B5E7C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 03:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238969AbjJCBN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 21:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjJCBNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 21:13:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0722C6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 18:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=JZrgAFcocfmJ7wr8txtlkIWUzzd0SjphU1ZT0UcIUj8=; b=Ihpa+wmITsTi43mwt/V3xZUuUq
        VqebiD33iHqOUu2ob/xLb7m1foi6aYUqIBT3TAfJVEUQ/XvXdD6oayeQ7ZTC+s0KM69jArTiwLWC7
        GZsgipBgX4hQ9Yb61MTEu8mbNHd4uwNdOGsXi2cLY4CyzNhBZjGIEYT6ban9no+wrRQboLdXQdex0
        EOKzQlTW0LyTVnNCgRjnzBq3V9Fi5PhNroohu0qpBwjZpOrG3ggfzZz0XMRvKw96u2oIP2NeO0Voi
        HezlkPDY/eNpfdHpxGvyfebR8EaS9ydZnfBjVfj5czZM3lbZfAJDQq1O4MOsD33ANlNpe5VrJBFZq
        0G7Pdj0Q==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qnTyx-00DcHx-1c;
        Tue, 03 Oct 2023 01:13:51 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 3/3] drm/rect: fix kernel-doc typos
Date:   Mon,  2 Oct 2023 18:13:49 -0700
Message-ID: <20231003011349.27593-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231003011349.27593-1-rdunlap@infradead.org>
References: <20231003011349.27593-1-rdunlap@infradead.org>
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

Correct typos of "translated".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
---
 include/drm/drm_rect.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/include/drm/drm_rect.h b/include/drm/drm_rect.h
--- a/include/drm/drm_rect.h
+++ b/include/drm/drm_rect.h
@@ -129,7 +129,7 @@ static inline void drm_rect_adjust_size(
 
 /**
  * drm_rect_translate - translate the rectangle
- * @r: rectangle to be tranlated
+ * @r: rectangle to be translated
  * @dx: horizontal translation
  * @dy: vertical translation
  *
@@ -146,7 +146,7 @@ static inline void drm_rect_translate(st
 
 /**
  * drm_rect_translate_to - translate the rectangle to an absolute position
- * @r: rectangle to be tranlated
+ * @r: rectangle to be translated
  * @x: horizontal position
  * @y: vertical position
  *
