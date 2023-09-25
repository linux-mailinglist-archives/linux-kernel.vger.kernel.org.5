Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774717AD63C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjIYKld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjIYKlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:41:31 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB38CAB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 03:41:24 -0700 (PDT)
Received: from 8bytes.org (pd9fe9df8.dip0.t-ipconnect.de [217.254.157.248])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 35AA81A225B;
        Mon, 25 Sep 2023 12:41:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1695638483;
        bh=Z21cjpEwnJ0hdKURVPPIzr3mYa3eyf350D/pmcSWVVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HhJ0slLoNuAoyb0U+OU/VEMgXofwh5saeBmpNqN4zpmezBJoPdsiLy36nCCv/88lG
         ahm7NQP00Z23f3z8njHTLiwcDZZcbtxuiox4owdEDWXq5+7eMTq6JJYc98QSKgZPcs
         HDVatqm14ijnOoNPtSh1nNa/spKy94pcawQl7wfygsHJJhRYyGPiUuILOhzfNbqptN
         LEJUQ62s3lrLBZme7GNTUhvDXZJNpMnV96fVBygstQKaLa816+8TuKdcNmfh0lkgg3
         XjkBfnON9b/4or4T6SD16l/sYL32Y8q3K4d23V4/9JfKwyiXbBxhw0FaO4uLQYaA6b
         v8TptXq9wAJnQ==
Date:   Mon, 25 Sep 2023 12:41:22 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] iommu: Remove duplicate include
Message-ID: <ZRFj0oDZOWxYAd9s@8bytes.org>
References: <20230818092620.91748-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818092620.91748-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 05:26:20PM +0800, Jiapeng Chong wrote:
>  drivers/iommu/iommu.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.
