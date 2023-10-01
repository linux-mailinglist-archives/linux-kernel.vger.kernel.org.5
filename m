Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F1C7B4961
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 21:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbjJATQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 15:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235327AbjJATQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 15:16:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABA7DA;
        Sun,  1 Oct 2023 12:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=aO8m3SGFbn9Y/+UxRKdfzdIADxyJ81ckpw/F3qJK1f4=; b=Wmka/CRYuKOgGHEJQoeoxW4c4a
        LZeb8VHu0CxMIas7lJmOeB1gKO79nANkLkjThfNpb5avbUX9szXkhvup4UHwgUVxnAg/afX4Xh+fX
        UNR4fpOpR0pRqbT5PNp/06HBG1nkUFvJLBmRinMYXcMchGWT1cHUiWMxO5OlWxf0QUr3QqNKcsn0K
        6KywVBv1TBvvbUlCcaxrl6tWuG7TCl/Di72/hELQ+d29R4QlZ7nh4B1FbQh5DcjVy3ktMGxJO2XIM
        FOb9YfVOo+lP/HiJzLLxYzcSxF77lWbRYLwJ+23zo+ZwKMec0vIkPeBPMw7UT3F7X4/kCYJFt4j4D
        lgGogkRQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qn1vf-00BYlp-0C;
        Sun, 01 Oct 2023 19:16:35 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: [PATCH 3/3] wifi: nl80211: fix doc typos
Date:   Sun,  1 Oct 2023 12:16:33 -0700
Message-ID: <20231001191633.19090-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231001191633.19090-1-rdunlap@infradead.org>
References: <20231001191633.19090-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct some typos.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
---
 include/uapi/linux/nl80211.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -167,7 +167,7 @@
  * following events occur.
  * a) Expiration of hardware timer whose expiration time is set to maximum
  * coalescing delay of matching coalesce rule.
- * b) Coalescing buffer in hardware reaches it's limit.
+ * b) Coalescing buffer in hardware reaches its limit.
  * c) Packet doesn't match any of the configured coalesce rules.
  *
  * User needs to configure following parameters for creating a coalesce
@@ -326,7 +326,7 @@
 /**
  * DOC: Multi-Link Operation
  *
- * In Multi-Link Operation, a connection between to MLDs utilizes multiple
+ * In Multi-Link Operation, a connection between two MLDs utilizes multiple
  * links. To use this in nl80211, various commands and responses now need
  * to or will include the new %NL80211_ATTR_MLO_LINKS attribute.
  * Additionally, various commands that need to operate on a specific link
