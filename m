Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3AE7F9D00
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 10:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbjK0J7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 04:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjK0J7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 04:59:35 -0500
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9714183
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 01:59:41 -0800 (PST)
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 994461A4799;
        Mon, 27 Nov 2023 10:59:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1701079180;
        bh=4fArJRY/2HnzmxUj53izSkP6rBCg7+/g9dmdWslHlew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HDXDP6XK3tzZcqks7doJbHJjpzTD3i0Mcr7rXbKut6VMKq7tn41JGS+AgtrMqADUR
         DycAaNxqepOoSCaUujibeVsWPBdWKwy/YnEvl3BOGnTDjOw6tYxvjmj9TF3hHtkWTB
         7Jo4MA/GjrNKC/YLux0u1nUjvAd6zOmMNrFECfE1Oacsiqk93/HXFpYHWmqqG8/LTJ
         ExUadNXoaVUy5ro2UpuFtenuUcPKFegLPml4oFD/4dG3oBRvhJrJg0C4CKE4EvrOnV
         P7ZFvI6nA62KbgeKc6ThxcHO9BnIkfIpUkQAlMyEdjJG53UEF9bsmE+EyqXD4DztWo
         903cjIF6XV4zQ==
Date:   Mon, 27 Nov 2023 10:59:39 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Kunwu Chan <chentao@kylinos.cn>
Cc:     suravee.suthikulpanit@amd.com, will@kernel.org,
        robin.murphy@arm.com, kunwu.chan@hotmail.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Set variable amd_dirty_ops to static
Message-ID: <ZWRoiywi9Y5nlSOn@8bytes.org>
References: <20231120095342.1102999-1-chentao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120095342.1102999-1-chentao@kylinos.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 05:53:42PM +0800, Kunwu Chan wrote:
>  drivers/iommu/amd/iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.
