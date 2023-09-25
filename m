Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5744C7AD49B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjIYJfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbjIYJfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:35:51 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 055FCEE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:35:44 -0700 (PDT)
Received: from 8bytes.org (pd9fe9df8.dip0.t-ipconnect.de [217.254.157.248])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 470061A21D7;
        Mon, 25 Sep 2023 11:35:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1695634544;
        bh=JzBWhwIWRMg4Tq8QQvrZiz3bg1CZWBEKQ3ri1lmLzbc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UlJzvfuoeati0DEOxo47X00IY6J5Df3D0tzZQT0xzzT4G/LWABtqc5SteZNOwrozr
         SBjq0+fAPRaTQsAHGwNnhX4S8R0E9TzR+oowMNfkopz17rxYbjCRFaE0C3fuNIATZE
         Cmgh6x370laUS+CtdMjeVSMbw6w72EcdVcXk63NwKVEUeV47OXSjQGabtW17hCkGJ8
         axIayGqSbyimKVBt9bAWN3OeWrzsU9FmyrNbZjnUIwSVhm5V5CoActapMaXHwSYE9R
         5yRVL8jGCTwC7C/UwDDzZYFxBi3s7vgFbHDVCGk5zHDaBO6sPUxdLt/XhQ0tIzb/VR
         I4ZV7/1hssu8g==
Date:   Mon, 25 Sep 2023 11:35:43 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Fixes for 6.6-rc
Message-ID: <ZRFUb6n6vusG4FRE@8bytes.org>
References: <20230922162114.GC23332@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922162114.GC23332@willie-the-truck>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 05:21:14PM +0100, Will Deacon wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-fixes

Pulled, thanks Will.
