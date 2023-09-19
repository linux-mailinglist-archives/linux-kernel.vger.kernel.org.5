Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5107A6CD1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 23:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbjISVPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 17:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjISVPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 17:15:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7821AC;
        Tue, 19 Sep 2023 14:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3IfYKnlxj0TrJi+X1H0u/hKHs8xuVODNL22xPNbkZv8=; b=nrQOth4PK6RQR77gOSQl091+Up
        4wZO4w7rFKSR0ZwU6Pea8sdr319E0HKzbjH3rNvYVUKsAojhzD7zvvATpkQM+jACR6pVpJoszUwuW
        pNH+EXGnXj6BjbLe9RvNBbwOQQhVHdpatxI+tpZxboA0vrG0pI2492S+O2q8t8P0t/9XtTeo77Rjt
        80+1RysPkDbWwWe0TLqyPASWxw5TaWO7LaL7LDbTG9E1cAjknrt6IlDKB5l7ecKgxMznOKSrlfbc+
        Qjkjt3tSj6DiZiTTSukvyJSLwR1LCi+rWcvZCCZFDaE4hldGUM3QYIl69ekq10vGYOlMiD2fTUjVf
        L0BUHjNA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qii41-001plN-8G; Tue, 19 Sep 2023 21:15:21 +0000
Date:   Tue, 19 Sep 2023 22:15:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <dchinner@redhat.com>
Cc:     Charles Han <hanchunchao@inspur.com>, corbet@lwn.net,
        djwong@kernel.org, allison.henderson@oracle.com,
        bhelgaas@google.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] Documentation: xfs: Remove repeated word in comments
Message-ID: <ZQoPaXNAwtu4wl02@casper.infradead.org>
References: <20230918071905.296081-1-hanchunchao@inspur.com>
 <ZQoMqI/QGPWEpkEi@rh>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lVi3OPmq9z4dmZW7"
Content-Disposition: inline
In-Reply-To: <ZQoMqI/QGPWEpkEi@rh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lVi3OPmq9z4dmZW7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 20, 2023 at 07:03:36AM +1000, Dave Chinner wrote:
> [cc linux-xfs@vger.kernel.org]
> 
> Hi Charles,
> 
> For future reference, can you CC the XFS list on XFS documentation
> changes please?  That's much preferable to sending patches to random
> developers and hoping they notice it....
> 
> On Mon, Sep 18, 2023 at 03:19:05PM +0800, Charles Han wrote:
> > Remove the repeated word "the" in comments.
> > 
> > Signed-off-by: Charles Han <hanchunchao@inspur.com>
> > ---
> >  Documentation/filesystems/xfs-online-fsck-design.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs-online-fsck-design.rst

To be fair, this new file isn't listed in MAINTAINERS, so
scripts/get_maintainer.pl doesn't know about it.  May I
suggest the attached patch?

--lVi3OPmq9z4dmZW7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-XFS-Update-MAINTAINERS-to-catch-all-XFS-documentatio.patch"

From e0eb2f0d1425e6a5dae23c983eb793afa5d040c1 Mon Sep 17 00:00:00 2001
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Date: Tue, 19 Sep 2023 17:12:45 -0400
Subject: [PATCH] XFS: Update MAINTAINERS to catch all XFS documentation

Assumes that all XFS documentation will be prefixed with xfs-, which
seems like a good policy anyway.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bf0f54c24f81..3554195022ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23640,8 +23640,7 @@ T:	git git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 P:	Documentation/filesystems/xfs-maintainer-entry-profile.rst
 F:	Documentation/ABI/testing/sysfs-fs-xfs
 F:	Documentation/admin-guide/xfs.rst
-F:	Documentation/filesystems/xfs-delayed-logging-design.rst
-F:	Documentation/filesystems/xfs-self-describing-metadata.rst
+F:	Documentation/filesystems/xfs-*
 F:	fs/xfs/
 F:	include/uapi/linux/dqblk_xfs.h
 F:	include/uapi/linux/fsmap.h
-- 
2.40.1


--lVi3OPmq9z4dmZW7--
