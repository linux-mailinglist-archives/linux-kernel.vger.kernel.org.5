Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E4F7A0E80
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 21:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjINTuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 15:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjINTuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 15:50:03 -0400
Received: from out-221.mta0.migadu.com (out-221.mta0.migadu.com [91.218.175.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC8C26AB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 12:49:59 -0700 (PDT)
Date:   Thu, 14 Sep 2023 15:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694720998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3n3IpNBBZ78x0DFAR+6q4POE9YbyrvlVPxf0V0KJEvQ=;
        b=dSTA2m3TMr86zE9HitOpXel+n6QkmUMRQiKubu6+eeHB0342fUe3VqFHHKAq8yDQQ5HH6a
        lwQLA9at96W5OLndLCfEz2aX1cD6ZcQ1jFSuPC8nh0fcUM0H+va5wGLH8v2iJppfgbHvd+
        zf1gJrAeiMbybKysugCBVVfoSDqRkwc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     bfoster@redhat.com, linux-bcachefs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH 9/9] bcachefs: Modify mismatched function name
Message-ID: <20230914194953.indh7neor2ejrnc5@moria.home.lan>
References: <20230914090457.32325-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914090457.32325-1-jiapeng.chong@linux.alibaba.com>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 05:04:49PM +0800, Jiapeng Chong wrote:
> No functional modification involved.
> 
> fs/bcachefs/alloc_foreground.c:514: warning: expecting prototype for bch_bucket_alloc(). Prototype was for bch2_bucket_alloc_trans() instead.

I've already fixed all of these.
