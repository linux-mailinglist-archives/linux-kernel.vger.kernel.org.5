Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AEE77F49B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 12:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350081AbjHQK6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 06:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350135AbjHQK6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 06:58:44 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFFD22D72
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 03:58:42 -0700 (PDT)
Received: from 8bytes.org (p4ffe1bae.dip0.t-ipconnect.de [79.254.27.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 4ED01280B2B;
        Thu, 17 Aug 2023 12:58:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1692269921;
        bh=ELb5VVnTKzaZUuaPkg7DH+QwaVNKekwnIp0RtJhTxxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IZ2zYN4n8udzDoFxW89rpXtSSXAVb4srCbWqAJ9HgL8kZUXWk02xKhIFAf5FYEIXW
         N7crgAIDLN5m/eaXnz1IduTnGw+r/okmO959pg6AAHOEL03MMPpi28ZgdKk8DmTxoh
         hc2lTI9BnPvlzihv4byfoabZoEmZfu5wjnmho6kGWcrqs112yoWhperERIOfLAWEhM
         +/utOZUPB2yNx85OM1fIzZN+9oASHPGjNoONY46gL1gRdPz+ZwN6eHSfk9Y1JK5ib1
         Uw8W43QMcVVE4V/5g0pzAlGLsPGA1ipO1Mgn4NJz4v361sH3WfOwWvUTJhsAUFOPFY
         VkTGezPhfgTtg==
Date:   Thu, 17 Aug 2023 12:58:40 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     suravee.suthikulpanit@amd.com, will@kernel.org,
        robin.murphy@arm.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] iommu/amd: Remove unused declarations
Message-ID: <ZN39YE8MCF6CTp9F@8bytes.org>
References: <20230814135502.4808-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814135502.4808-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 09:55:02PM +0800, Yue Haibing wrote:
> Commit aafd8ba0ca74 ("iommu/amd: Implement add_device and remove_device")
> removed the implementations but left declarations in place. Remove it.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  drivers/iommu/amd/amd_iommu.h | 3 ---
>  1 file changed, 3 deletions(-)

Applied, thanks.
