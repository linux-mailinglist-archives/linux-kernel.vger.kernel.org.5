Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050B680E727
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjLLJQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjLLJQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:16:54 -0500
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D5C9CF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:16:59 -0800 (PST)
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 4CE841A4F1D;
        Tue, 12 Dec 2023 10:16:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1702372618;
        bh=3mw5c2s43EoXfOonhkPHbbLEkkw3V57oAh17CvQIgj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lVtlpzcO9jbf/R/j1Xgtidxl3Z01rGwCu8IoNGQ3FlizsM+vaKVSvJK+S1r2cBrQv
         tKGjhN3mL5EKSZDDYW1S2AzIIWsFMPnQSgU1ipmTbQhA1YP1s6bRWOu1XBjNZ0JGji
         ANDiSuOpW+bd4lV1FHnhGfy/K2vlg07qDcx6D+akjk48ugCiXRv/Nt271yEtXciQag
         FmS+eujGHTLO9bDp8HQ23uQ+5nj7tmT1qjXQq8A4oJ3YU04sJ6xMFBRsOXNR2g1a1W
         tTrbkLFU/Qv0lRvTm3dYg9EtfexpEMo9htQ/eOr2JBkArQ0oG0xYihbRcLVCsMrX32
         Gu9ecyzXCkPZw==
Date:   Tue, 12 Dec 2023 10:16:57 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu: Set owner token to SVA domain
Message-ID: <ZXglCeP3YT1Eq2Er@8bytes.org>
References: <20231208015314.320663-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208015314.320663-1-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 09:53:14AM +0800, Lu Baolu wrote:
>  drivers/iommu/iommu.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.
