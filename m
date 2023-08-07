Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFF87724C7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbjHGM4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjHGM4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:56:15 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DACC1BC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:56:13 -0700 (PDT)
Received: from 8bytes.org (pd9fe94eb.dip0.t-ipconnect.de [217.254.148.235])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 9C0CF2802C0;
        Mon,  7 Aug 2023 14:56:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1691412972;
        bh=6Xy2YS2W3qgRvHtmtu9Lpdsks7qVo10Gru1ffayWzM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZIWY4otYAViQBjh6/KLeMMqTKBYnq8otbfD4bQzLWO/xEPlJTewjO0BNknpNnXy5o
         j7kpVKKcLDoTEsEFDWeXbsOouY6fNL0NLuy7UGvX82EVum2Fhtaz83hZNiE5TC+5pO
         ki53ua5JyLT0XiFSsAeRuOmf7HsP6guxutu2t2suOluvUkz38xs0Na5jd3+QK43wDA
         rPZyubg8wCjj+UU1WAvlQvUIR8EtekJ+Z7PKqlX1YudYaQa0be7WIxS0E23eLbfxfm
         iV8TWUG8pzFUgJLwFNPOpOkXvRpV86Nh9eJUSPEG/xURFb9nxjzbbOUSRD2+VzC8Vd
         4o/gorM2edJWQ==
Date:   Mon, 7 Aug 2023 14:56:11 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] iommu/amd: Remove unsued extern declaration
 amd_iommu_init_hardware()
Message-ID: <ZNDp61liCikysQGf@8bytes.org>
References: <20230802133201.17512-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802133201.17512-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 09:32:01PM +0800, Yue Haibing wrote:
>  include/linux/amd-iommu.h | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.
