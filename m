Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0602F7AD568
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjIYKJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjIYKIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:08:50 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CF181726
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 03:08:35 -0700 (PDT)
Received: from 8bytes.org (pd9fe9df8.dip0.t-ipconnect.de [217.254.157.248])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id C74D51A225C;
        Mon, 25 Sep 2023 12:08:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1695636514;
        bh=bYPK4L80SaBw9siaRRxaOBF4u3tr6pKF6RCfC0nKevQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Esa5JeSzJpgWFogLtHmJEyNBE/w4bf6DZqnhGGQlXVMwSg3ylrp2fo4mfzkLisFH/
         qFwvYeWxJOZiwMiHSPELxlB/mWyALQRRsiu4b54hzi2P8qyoN1geSbO6qbizlwVFhN
         Jucv84Ahlo9zUJnlV89BI2zmqLYDivoeujsSazysbPgi65jmfQ8IpB+BtIhxGW9cHk
         xNCpDqg/YloofwEZ25IzePc8BqnWYm52FqufjxjEaYQbYyc5XLRgImBKAr0hO/HyAU
         mUZV+vLRrcel76tW8xeRrZyC5E59btVCWAky22rXhXj8RTO4wDXyy8l2jp0gliB0cN
         PxUJH3S4Hw36g==
Date:   Mon, 25 Sep 2023 12:08:32 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, zhangzekun11@huawei.com,
        john.g.garry@oracle.com, dheerajkumar.srivastava@amd.com,
        jsnitsel@redhat.com
Subject: Re: [PATCH v3 0/2] iommu/iova: Make the rcache depot properly
 flexible
Message-ID: <ZRFcIDNeeVrVnKvD@8bytes.org>
References: <cover.1694535580.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694535580.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 05:28:04PM +0100, Robin Murphy wrote:
> Robin Murphy (2):
>   iommu/iova: Make the rcache depot scale better
>   iommu/iova: Manage the depot list size

Applied, thanks.
