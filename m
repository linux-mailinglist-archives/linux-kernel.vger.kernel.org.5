Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6AC7B44C1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 02:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbjJAABP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 20:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbjJAABJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 20:01:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78ADFD3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 17:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=8JOzdz2MFv/hofQCEiBSlk+fe2zZYPTTLqOrgrgxTrs=; b=aY50vHx/8TJHs4pwYHtSuo1O5S
        1EsyaGWg4BrtrGszYUgzlr94t/eiQPICWutIAGdZZy9IKRehjHBzzxmCDLkqWzlIf6iP8KFd0udpB
        3WXed1UDAYg6Q6G3ge7aU988Lj7LrBFwJFCju8L0sl9B4FOzn6PTMbeBzYHRFOCMkXhhqix1lm+yU
        1K+4l2iHJYcF9dAmvkxI7LtSkj9596mou/lgKTCPXfUo2l0f4SRzrfkTKLdIfVk7EHQIdQLwq8jtc
        90J/rJkHzUDqVI6GuKZ5HEoY7IXmm4mCnmXSQ8+pmc+43mCSmkykt1icHrSJUG1cCFxvhefb64oD6
        PjceNw7w==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qmjtR-00AFOE-2u;
        Sun, 01 Oct 2023 00:01:05 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Li Yang <leoyang.li@nxp.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        Roy Pledge <Roy.Pledge@nxp.com>
Subject: [PATCH] soc: fsl: dpio: fix kernel-doc typos
Date:   Sat, 30 Sep 2023 17:01:05 -0700
Message-ID: <20231001000105.26766-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231001000105.26766-1-rdunlap@infradead.org>
References: <20231001000105.26766-1-rdunlap@infradead.org>
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

Correct spelling of 2 words.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Li Yang <leoyang.li@nxp.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Roy Pledge <Roy.Pledge@nxp.com>
---
 include/soc/fsl/dpaa2-io.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/include/soc/fsl/dpaa2-io.h b/include/soc/fsl/dpaa2-io.h
--- a/include/soc/fsl/dpaa2-io.h
+++ b/include/soc/fsl/dpaa2-io.h
@@ -22,7 +22,7 @@ struct device;
  * DOC: DPIO Service
  *
  * The DPIO service provides APIs for users to interact with the datapath
- * by enqueueing and dequeing frame descriptors.
+ * by enqueueing and dequeueing frame descriptors.
  *
  * The following set of APIs can be used to enqueue and dequeue frames
  * as well as producing notification callbacks when data is available
@@ -33,7 +33,7 @@ struct device;
 
 /**
  * struct dpaa2_io_desc - The DPIO descriptor
- * @receives_notifications: Use notificaton mode. Non-zero if the DPIO
+ * @receives_notifications: Use notification mode. Non-zero if the DPIO
  *                  has a channel.
  * @has_8prio:      Set to non-zero for channel with 8 priority WQs.  Ignored
  *                  unless receives_notification is TRUE.
