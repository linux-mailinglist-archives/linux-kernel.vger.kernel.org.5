Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3737D29DE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjJWGEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJWGEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:04:08 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19371A4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:04:06 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B15A668BFE; Mon, 23 Oct 2023 08:04:00 +0200 (CEST)
Date:   Mon, 23 Oct 2023 08:03:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Yan Zhao <yan.y.zhao@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2] swiotlb: Rewrite comment explaining why the source
 is preserved on DMA_FROM_DEVICE
Message-ID: <20231023060359.GA11876@lst.de>
References: <20231020154215.2191840-1-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020154215.2191840-1-seanjc@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to the dma-mapping tree for Linux 6.7.
