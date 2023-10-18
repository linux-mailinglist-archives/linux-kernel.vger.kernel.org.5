Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C2F7CD684
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbjJRIa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235179AbjJRIaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:30:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0E9F9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:30:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FC5C433C8;
        Wed, 18 Oct 2023 08:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697617853;
        bh=GkBtb/Y75NMIU5FKadFqv7MuoG24n58h4xP9hUw2zLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aDJWRhufEK83/LzJb5vcxR8A5NbwjwTMUcar5RpMkFUKPwqqDjvd1Ck70cQWDObbF
         77lBX+Y1ZfJs1hnf7BpjT9WBZSx1RoSv9MjQkjzQeVZIBOIfjYPuU0BPCLeUlUKT1I
         GjfmLMois+u93InLrM2takbAhH/vHUheuIzhVJoA=
Date:   Wed, 18 Oct 2023 10:30:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saeed Mahameed <saeed@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <2023101810-snugness-ferocious-01ec@gregkh>
References: <20231018081941.475277-1-saeed@kernel.org>
 <20231018081941.475277-3-saeed@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018081941.475277-3-saeed@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 01:19:38AM -0700, Saeed Mahameed wrote:
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB

<snip>

> +MODULE_LICENSE("Dual BSD/GPL");

See, it's a mess already :(

