Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA12678A65F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 09:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjH1HTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 03:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjH1HSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 03:18:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B2511D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 00:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JDF5Ul0Vprg5xm1W4pcKhuwPSx7uDfjAecuTqOqRbt4=; b=W7g0h3aqPWXvcptFszqKVFk7yp
        PenBaUCvtR+0TeXGjdOGIATPjCXrJjEt2e3eROyuP9GAoDGmVbFeNOJdIC5zmj1QuZGw2cKOK2Xnx
        NGsATB7WnYznCVg1UMGG/VMUBFN+hd3eodQ9ua2KVhyryNyJONVGsAHW/mPPQnBkzMFudt2aVs764
        AYUXJZbj4zGfX2GeBaV31gP3CBVX3b/IWrfNKc7e39OKHG3nfRi6aZrJyJAW0f/LOIbzrM7RzwKKY
        zkO9d85+NG9a1quNVCupXhk2/jpGnZIclSKCmaZjGd5nUL0K/2AP7vqzsQ1lYLT4V+L7kjfOnq/AQ
        LK1qtBwA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qaWW4-0092wr-1N;
        Mon, 28 Aug 2023 07:18:28 +0000
Date:   Mon, 28 Aug 2023 00:18:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yunlong Xing <yunlong.xing@unisoc.com>
Cc:     pmladek@suse.com, senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, linux-kernel@vger.kernel.org,
        enlinmu@gmail.com, enlin.mu@unisoc.com, yunlong.xing23@gmail.com
Subject: Re: [PATCH] printk: export symbols for debug modules
Message-ID: <ZOxKRCE9tpJHDy3E@infradead.org>
References: <20230815020711.2604939-1-yunlong.xing@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815020711.2604939-1-yunlong.xing@unisoc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 10:07:11AM +0800, Yunlong Xing wrote:
> From: Enlin Mu <enlin.mu@unisoc.com>
> 
> the module is out-of-tree, it saves kernel logs when panic

As with all other symbols not used in tree:

NAK out of policy.

