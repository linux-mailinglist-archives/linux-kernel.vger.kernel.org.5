Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5162D7E641D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 08:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjKIHBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 02:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjKIHBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 02:01:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318F93271
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 23:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V7XVjzYWSOnWors9qJgYaHQ4LNgHkYieICZjMg/iyds=; b=tBz2YcV+kG0axKMhP0RySHIJNc
        zAuhn/x7JSpBbUVrO6CX1Z2u3/U9UBzfCG5j3gO15M7KCl0D+nUTAmp05TQyupxKQhw4uhBC90+D0
        EYIU/tjCOBZtjBncj6Zz4c1yOfsMtDJGcGBxBM7VDUHIHTuUFIlWUWjxG+hPxo9rYCvoD/+JMBDEU
        y2TcctcnRo9Yq20JI6eEtHoSkKDe6d7KLVcNtRlCRRTaBxJkHqHVG+s11RlDcGAPvIWsTbqxao61E
        hPnslVL4b+ABWA5plBLmf3POJzG/2U7IZD5wtZetWDyhOW1DuFoPcYJ9Yrp3PNqlIRlPXlQ39cs9G
        +fbZGNvQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r0z2U-005SYB-1n;
        Thu, 09 Nov 2023 07:01:18 +0000
Date:   Wed, 8 Nov 2023 23:01:18 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     peterz@infradead.org, will@kernel.org, gfs2@lists.linux.dev,
        boqun.feng@gmail.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] refcount: move kdoc to header definition
Message-ID: <ZUyDvv0na03qnSH+@infradead.org>
References: <20231106191138.3179599-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106191138.3179599-1-aahringo@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 02:11:36PM -0500, Alexander Aring wrote:
> This patch moves the kdoc for refcount_dec_and_lock functionality to
> it's header prototype declarations.

That's not how kerneldoc works.  The comments should be next to the
implementation.

