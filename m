Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037CF7F32DF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbjKUP5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbjKUP5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:57:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491D9191
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oFzJ1ey/G97fMhCwFS7iwCR0IxEMgBFyG/rXC16E8Oo=; b=iR2VOzSXrcf6qyDi10UYrLdGac
        IhF76OJSoyGoO7Z23Ln/nRHFreqvwSe+Xn5ld6+MiSIyKAYCnZ8r/Zmz+d9ZScXVLe0NtGdO0Q7M3
        Xz85NPTrS8up9nq6M+Vrzrp8CKJuPR7viRU6thv0qqCAsEmpxZ86Rj0KLaMJCRnGeRGZKPQV4E3HJ
        Z1vJhO6Scb+YpSLFt9GJpjs0+lF7zUAWJMEpTYUT5s9llpDsFwJ2tzaqQRuQODHJHwK8lZFruEjBc
        YrjpJfxZrbikp1aohPgnzzOQYjYn1Szj+hHksJpwuyK6YAEXK+BFEh5bLeUrfeoEgiocHC0YzNPaN
        C9y4Fvug==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r5T7W-005ioc-JW; Tue, 21 Nov 2023 15:57:02 +0000
Date:   Tue, 21 Nov 2023 15:57:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Zhiguo Jiang <justinjiang@vivo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v2] mm: ALLOC_HIGHATOMIC flag allocation issue
Message-ID: <ZVzTThaEgDcbvtM9@casper.infradead.org>
References: <20231121075129.1530-1-justinjiang@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121075129.1530-1-justinjiang@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 03:51:29PM +0800, Zhiguo Jiang wrote:
> Update comments and modify variable highatomic_allocation to highatomic.

You sent the patch relative to your last patch again.
You have to send the patch relative to Linus' tree or Andrew's tree.
