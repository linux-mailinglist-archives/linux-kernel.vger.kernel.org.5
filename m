Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93FB7CA0AD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjJPHfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjJPHfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:35:37 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7181EA
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:35:34 -0700 (PDT)
Received: from 8bytes.org (p4ffe149c.dip0.t-ipconnect.de [79.254.20.156])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id C0F6A1A45AE;
        Mon, 16 Oct 2023 09:35:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1697441731;
        bh=f6vgjRWU0QyKNDLv/KAm7cH3YOd4McoY7nD9XRt9FkY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wCDHL8rfWK46B4orPzg2Z5Fo58Gc+jYzkYeFIUnXVClC5dIu7oSCZBQaXO3w9C9vS
         Is6iIKJrc6uAyHwGSA3kQmgqUahC1g1F9hQcJdEHmNroTfMpSbQRmpLDQaBKAY11oc
         ZJGPLBx+fD0AaLAJd1nJcGyG2bYaI6KP7BEWkEDAnQI26kqbMGyD/sRBYhhEdqyCqv
         n7V2kkIRCDbub3ee0CT74+dQuPC1FXhjWi3CsD+h5qBUpByBZ39QY2esJ84jDZAVdh
         Sd1zx5NLDL6rlEPrkiRwxXmtmPuhw2/FfFZ8FD8IBRC7lba1kc6wOCdTWMt6MS8O1O
         vuADtzWr72dGA==
Date:   Mon, 16 Oct 2023 09:35:30 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 6.7
Message-ID: <ZSznwiSYnoan17F6@8bytes.org>
References: <20231013120205.GA13843@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013120205.GA13843@willie-the-truck>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 01:02:06PM +0100, Will Deacon wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

Pulled, thanks Will.
