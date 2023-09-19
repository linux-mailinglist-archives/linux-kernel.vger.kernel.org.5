Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8C47A6E79
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 00:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbjISWOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 18:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbjISWO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 18:14:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EEE1719;
        Tue, 19 Sep 2023 15:12:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42535C433C7;
        Tue, 19 Sep 2023 22:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695161460;
        bh=TxPDaCzDuBtdgZZ8DzOwQCio8mGeSW2DV4zUeGIh4DQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HqlRNKmiYE0ueGPgs9UWstq3xV0+1OGxN+QLP9FhnSdFRVp0/Q0i1YnIREI+Z1dVh
         PNjWLKzJ1+BqVNX5DSIbOmZ9B3joRPO5i+iZ2hn+omfSxjAbILIG+kZCN33MuruMwt
         6sJaZJCZuWDm7n8yWzqhV6CXw3UfjxaPojWhSpg0iivNqAHZdpwyphHDygKWKSoCbr
         BZ3Gao5m0BVof7pz9nj2q2zlH5f8DtShh/lpBhygUK4wz72n98WoYmsSvvEpIOUm1p
         mRTWSoufS0lT9iAt0CBRvMSGeDQnbYElxbwSYXgyCEUxcso5wKXR/wlIRgM29dgrta
         3nCNhHhmH33ww==
Date:   Tue, 19 Sep 2023 15:10:59 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <dchinner@redhat.com>
Cc:     Charles Han <hanchunchao@inspur.com>, corbet@lwn.net,
        allison.henderson@oracle.com, bhelgaas@google.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH] Documentation: xfs: Remove repeated word in comments
Message-ID: <20230919221059.GJ348018@frogsfrogsfrogs>
References: <20230918071905.296081-1-hanchunchao@inspur.com>
 <ZQoMqI/QGPWEpkEi@rh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQoMqI/QGPWEpkEi@rh>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Yup.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> > ---
> >  Documentation/filesystems/xfs-online-fsck-design.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs-online-fsck-design.rst
> > index 1625d1131093..a0678101a7d0 100644
> > --- a/Documentation/filesystems/xfs-online-fsck-design.rst
> > +++ b/Documentation/filesystems/xfs-online-fsck-design.rst
> > @@ -1585,7 +1585,7 @@ The transaction sequence looks like this:
> >  2. The second transaction contains a physical update to the free space btrees
> >     of AG 3 to release the former BMBT block and a second physical update to the
> >     free space btrees of AG 7 to release the unmapped file space.
> > -   Observe that the the physical updates are resequenced in the correct order
> > +   Observe that the physical updates are resequenced in the correct order
> 
> Change looks fine, though.
> 
> Reviewed: Dave Chinner <dchinner@redhat.com>
> 
> -- 
> Dave Chinner
> dchinner@redhat.com
> 
