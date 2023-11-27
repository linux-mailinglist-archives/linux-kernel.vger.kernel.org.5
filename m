Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1232D7F9D0F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbjK0KDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjK0KDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:03:36 -0500
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74F13C0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:03:42 -0800 (PST)
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id AFAD41A6DDC;
        Mon, 27 Nov 2023 11:03:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1701079421;
        bh=7mEHQzLvt5ANszOUbDai1+OIHnL6YZTzhsqHHv6SGr4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bu82IzlcjQk7yU+93aV8FsKw5tjv7diEHhh4QGS3Q3oVq8HU3lUGJlxLCLlpACUZU
         ubG1awPJ92qMFDObCEa+80ICvZg0V5IuEblE45iMP4rH3KMpKiX7meKy4R5ymu4C/n
         X0J7K9zPSNOMdJfA2Lp4+jcVwsmuUnzvuSK0+ptxSJ9rwfGDDN6vWge6nzHHKRqDSh
         TcS1eFJLLuzSqAZPNd0A6E2mX27ZcDbMe5GcMlrcd7AoqRN8G9F6JS1oPu4aNrf1fG
         fopS2epbj0g1XuoqA68twe9mEw27KexMPH4JHJ9PUPOOw0/PHlPxAdaYrgrXSyWcew
         AcMKiPei/zBfw==
Date:   Mon, 27 Nov 2023 11:03:40 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     will@kernel.org, iommu@lists.linux.dev, jgg@nvidia.com,
        baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org,
        jsnitsel@redhat.com
Subject: Re: [PATCH v6 0/7] iommu: Retire bus ops
Message-ID: <ZWRpfKdkA0fsEu-J@8bytes.org>
References: <cover.1700589539.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1700589539.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 06:03:56PM +0000, Robin Murphy wrote:
> Robin Murphy (7):
>   iommu: Factor out some helpers
>   iommu: Decouple iommu_present() from bus ops
>   iommu: Validate that devices match domains
>   iommu: Decouple iommu_domain_alloc() from bus ops
>   iommu/arm-smmu: Don't register fwnode for legacy binding
>   iommu: Retire bus ops
>   iommu: Clean up open-coded ownership checks

Applied, thanks.
