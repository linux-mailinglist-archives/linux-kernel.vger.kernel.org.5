Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADEB7D70FB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344384AbjJYPck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 11:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbjJYPci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 11:32:38 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DAB5191
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 08:32:33 -0700 (PDT)
Received: from 8bytes.org (p4ffe149c.dip0.t-ipconnect.de [79.254.20.156])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 87E851A5736;
        Wed, 25 Oct 2023 17:32:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1698247950;
        bh=Z44oKumXmNElfkclGxRpmyPsTR5qH0d3Pur+vFzUclw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=3pnU97hWaP7qF7xRadKvd7jH2sZQNQP9kg6tzXIMGWM+CmNJFpBxGjkWo31QOGIM+
         nRDC5EjeOjLgmjRLLJkWvKNyMTXV147pkm4cCHXMgNX2tnFRTBlk8hz7dK9hkadJoS
         26hQZ1+GgKu6wk8JTABdxyLfs/efkTpBP8HylQN/rcEQw8kL8mmXGk/84+ERGqAcn9
         I5gB2Z0r5BRxS1wg7gvqvwSV7PNWm8IsIU1hTKcqOJHxEwFJbe+fYhSxPJ2IxAgvww
         OD3Fx45XUCpGRZ4s5ZzOUxth41l8+l0+Q71qPA7osURA+dWoTlwBXbBj6IUhvvytEh
         hGokUPficRUBw==
Date:   Wed, 25 Oct 2023 17:32:29 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Stephen Rothwell <sfr@canb.auug.org.au>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Revert "iommu/vt-d: Remove unused function"
Message-ID: <ZTk1DTy5w8XwlA0K@8bytes.org>
References: <20231025131854.375388-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025131854.375388-1-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 09:18:54PM +0800, Lu Baolu wrote:
>  drivers/iommu/intel/pasid.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Applied, thanks.
