Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CD57723EB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbjHGM2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjHGM2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:28:38 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9DECE79
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:28:37 -0700 (PDT)
Received: from 8bytes.org (pd9fe94eb.dip0.t-ipconnect.de [217.254.148.235])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id D568B2802C0;
        Mon,  7 Aug 2023 14:28:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1691411317;
        bh=Zf7mBjtKumP8S/ql7gFmyW5785yudzSFvZ6h4B2GBmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N+Fusk53UgSQxfDMm5/1mvjjk+EoXfNDGrX1RWXalVYnCZciXaflypYS/1a4YXRIa
         no0MzYQ8/XTsXFbV2XYR6EaxLl18vnGCGvESY6Oh6lR7TavG9w86qELIfDwd/IQ5l8
         z65tqvKzGMTnZD+9GJJHeCh7Omq1kWiaA4DKtBRZabkx1D0nF1z0zHNyxBSHwqQIHV
         W70SfT42fM51+n2Du+dCIoONYmnPl3uWnMt3q0vBk1IToz4HS//OjI3UtMU2hTKRZ/
         OPIlfxpmyQea7QuM152P/UrnYUNEd1qW5qG4f+lD0M+CHzjbzSSEI4Q4QFjSTVV2XM
         6k6WT0KizjpVA==
Date:   Mon, 7 Aug 2023 14:28:35 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Min-Hua Chen <minhuadotchen@gmail.com>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/apple-dart: mark apple_dart_pm_ops static
Message-ID: <ZNDjc0XdP9MnNyxr@8bytes.org>
References: <20230720232155.3923-1-minhuadotchen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720232155.3923-1-minhuadotchen@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 07:21:54AM +0800, Min-Hua Chen wrote:
> Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
> Acked-by: Sven Peter <sven@svenpeter.dev>

Applied, thanks.
