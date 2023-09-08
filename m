Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E526479847C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 10:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238816AbjIHI7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 04:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjIHI7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 04:59:02 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D681BC8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 01:58:58 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F2B8068B05; Fri,  8 Sep 2023 10:58:54 +0200 (CEST)
Date:   Fri, 8 Sep 2023 10:58:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_tingweiz@quicinc.com
Subject: Re: [PATCH] Revert "dma-contiguous: check for memory region
 overlap"
Message-ID: <20230908085854.GA12056@lst.de>
References: <1694073836-5125-1-git-send-email-quic_zhenhuah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1694073836-5125-1-git-send-email-quic_zhenhuah@quicinc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applied.
