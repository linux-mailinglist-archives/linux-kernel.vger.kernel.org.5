Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B579880D43B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344931AbjLKRk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344782AbjLKRkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:40:21 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BF511A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:40:26 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1317268BFE; Mon, 11 Dec 2023 18:40:21 +0100 (CET)
Date:   Mon, 11 Dec 2023 18:40:20 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc:     Christoph Hellwig <hch@lst.de>,
        Petr Tesarik <petrtesarik@huaweicloud.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Wangkefeng <wangkefeng.wang@huawei.com>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Petr Tesarik <petr.tesarik1@huawei-partners.com>
Subject: Re: [PATCH RESEND] swiotlb: reduce area lock contention for
 non-primary IO TLB pools
Message-ID: <20231211174020.GA28041@lst.de>
References: <20231201121352.195-1-petrtesarik@huaweicloud.com> <20231211140111.5dbb74c0@meshulam.tesarici.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231211140111.5dbb74c0@meshulam.tesarici.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 02:01:11PM +0100, Petr Tesařík wrote:
> Hi Christoph,
> 
> just a friendly ping about the following patch. Does it need more time
> to review, or has it gone lost?

I've just been a bit too busy.  I'll do a run on dma-related things
this week.

