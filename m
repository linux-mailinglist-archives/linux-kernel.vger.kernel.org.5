Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CAF75AD8A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 13:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjGTLyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 07:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjGTLys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 07:54:48 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE55C26BB;
        Thu, 20 Jul 2023 04:54:28 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 554AB6732D; Thu, 20 Jul 2023 13:54:09 +0200 (CEST)
Date:   Thu, 20 Jul 2023 13:54:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     Christoph Hellwig <hch@lst.de>, corbet@lwn.net,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        akpm@linux-foundation.org, paulmck@kernel.org,
        catalin.marinas@arm.com, rdunlap@infradead.org,
        peterz@infradead.org, rostedt@goodmis.org, kim.phillips@amd.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH v3] dma-contiguous: support numa CMA for specified node
Message-ID: <20230720115408.GA13114@lst.de>
References: <20230720082517.GA7057@lst.de> <20230712074758.1133272-1-yajun.deng@linux.dev> <25942dafbc7f52488a30c807b6322109539442cf@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25942dafbc7f52488a30c807b6322109539442cf@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 08:47:37AM +0000, Yajun Deng wrote:
> It's based on linux-next tree.
> 
> This patch should be after my other patch in linux-next tree.
> a960925a6b23("dma-contiguous: support per-numa CMA for all architectures").

Where did this land?  dma patches really should be going through
the DMA tree..
