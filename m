Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EFF7ADA21
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjIYOb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjIYOb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:31:27 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE251112
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 07:31:20 -0700 (PDT)
Received: from 8bytes.org (pd9fe9df8.dip0.t-ipconnect.de [217.254.157.248])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 48E1D1A13AC;
        Mon, 25 Sep 2023 16:31:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1695652279;
        bh=cu4NyoAXBKa2NBwr+WUcpQdkCCtFrBgwiyTHhUC4jio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hUhsVM/+9UnsNknCsWCCsAL9MAIWY6UQ30/z7fR/VyvVBmom/6Y56Lqs5GLZqvMJq
         dC1mu5UMSVCbNpTlY2kSYsm6c1E3mIJMWt2hUml1bHW+QecXIPiA9Zx2WJlOfVcsG+
         EqEMMpxcDviS7wg7wugYUeQ8uK8ftcbft0QYCS3mis0TR2SkAF3/2OlWdlcohhwXZv
         MyZg4i8JoCSZra/VnWJRpxQKZMFboMvm9osYERSwst8QT4umYEdfzYzCQ56+5fmBzo
         s2J6lmY9arewT3uuftYoIzoeSkOx1NtPh9jVJkL/a12v9tdzHYACaCyJFv9RkuqjXD
         2XOFt4qwnKu9w==
Date:   Mon, 25 Sep 2023 16:31:18 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Zhang Rui <rui.zhang@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] [PULL REQUEST] iommu/vt-d: Fixes for v6.6-rc4
Message-ID: <ZRGZtgWwvzWJCm38@8bytes.org>
References: <20230925120417.55977-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925120417.55977-1-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 08:04:16PM +0800, Lu Baolu wrote:
> Zhang Rui (1):
>   iommu/vt-d: Avoid memory allocation in iommu_suspend()

Applied, thanks.
