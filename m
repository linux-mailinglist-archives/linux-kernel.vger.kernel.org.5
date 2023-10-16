Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF15C7CA0B1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbjJPHgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjJPHgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:36:04 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4977F7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:36:01 -0700 (PDT)
Received: from 8bytes.org (p4ffe149c.dip0.t-ipconnect.de [79.254.20.156])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 328211A45BC;
        Mon, 16 Oct 2023 09:36:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1697441761;
        bh=nt+xCM+bbOr7Tl+Bpnd6YqrLyUak9Maws/2C4cwPfME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BbcsUWWdDSGJZOarRKA+DdgcrK7nsBYntbXu+2v9JvIca04ORkqddyNVHHvQL9c2c
         VyuUAa6MoKYjL5ye6GpXPfi+dQHSg67kU0r30Sw01LaXt0CMvJ2RYteMfQQziyqmza
         eHiRuu2snYzzjPSFMzUo+mQ5OMG0SuuIPT0HEnMGKgBP2KPNBTU26svreDEgP6sybs
         tEcWYvpw5MPloCAcGmHwlzAJb7d+VlGVjcbne0lWPR0SHgYH+GSq37JL/tJ+tPXRPD
         Q9EDnY3zukteFkPPW01LBut2lX7NTuocDSMVgyx+URMpCoTq91YicfKqTo/g4jfZW6
         na9RKMqyYh3yg==
Date:   Mon, 16 Oct 2023 09:36:00 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Jingqi Liu <Jingqi.liu@intel.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] [PULL REQUEST] Intel IOMMU updates for Linux v6.7
Message-ID: <ZSzn4P4EcvZu0FBR@8bytes.org>
References: <20231016032830.101321-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016032830.101321-1-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 11:28:26AM +0800, Lu Baolu wrote:
> Jiapeng Chong (1):
>   iommu/vt-d: Remove unused function
> 
> Jingqi Liu (3):
>   iommu/vt-d: debugfs: Dump entry pointing to huge page
>   iommu/vt-d: debugfs: Create/remove debugfs file per {device, pasid}
>   iommu/vt-d: debugfs: Support dumping a specified page table

Applied, thanks Baolu.

