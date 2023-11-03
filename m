Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABA97E0159
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346462AbjKCIfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 04:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235989AbjKCIfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 04:35:42 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A580D43;
        Fri,  3 Nov 2023 01:35:40 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6825F68AA6; Fri,  3 Nov 2023 09:35:35 +0100 (CET)
Date:   Fri, 3 Nov 2023 09:35:35 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Petr Tesarik <petrtesarik@huaweicloud.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Tesarik <petr.tesarik1@huawei-partners.com>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>, patchwork@huawei.com,
        Wangkefeng <wangkefeng.wang@huawei.com>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        petr@tesarici.cz, miaoxie@huawei.com, weiyongjun1@huawei.com,
        guohanjun@huawei.com, huawei.libin@huawei.com,
        yuehaibing@huawei.com, johnny.chenyi@huawei.com,
        leijitang@huawei.com, ming.fu@huawei.com, zhujianwei7@huawei.com,
        linuxarm@huawei.com, stable@vger.kernel.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v2 1/1] swiotlb: do not free decrypted pages if dynamic
Message-ID: <20231103083535.GA17432@lst.de>
References: <20231102071821.431-1-petrtesarik@huaweicloud.com> <20231102071821.431-2-petrtesarik@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102071821.431-2-petrtesarik@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applied.
