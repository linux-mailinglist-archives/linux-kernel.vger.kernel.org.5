Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA7C813336
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573494AbjLNOfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573505AbjLNOfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:35:18 -0500
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2D7FE8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:35:23 -0800 (PST)
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 6A0421A11BC;
        Thu, 14 Dec 2023 15:35:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1702564522;
        bh=HrmgNZoTbTl3lSWG3muA8VTTeVGecUWY+AkVUaur7KU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aXqpuAArM2r6WSqvflso7cko9ggggynksNAll3fHte1UhiEUW1Va11Guh7GX5bCXM
         71ZGWmweXyh11WG3O2ffgwtoro4rSUOhsdP/2H/qtascBty8Vdu6D7BZxU7rbY0EAp
         7AKIt47XNRDL+1Dl0/e272ZDIcL7vMwHqaVAgcFdpKYjxP0QZbjYWye7QX1uqG5I/j
         x5cJiFWvYNb70NwIZwWcbbdMGT/5aQgiupc0xjbA81BwlY4mCNmjdcKkocfmnN9nYr
         F8FeJp3il/3qqS26JtymiQSZxtSsJfjsl70aikQwc49BjHWTRPvjUXTVLW8O8NFYNq
         CbXVsyBqt1ciQ==
Date:   Thu, 14 Dec 2023 15:35:21 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 6.8
Message-ID: <ZXsSqZGxulavBmuw@8bytes.org>
References: <20231214104327.GA924@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214104327.GA924@willie-the-truck>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 10:43:28AM +0000, Will Deacon wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

Pulled, thanks Will.
