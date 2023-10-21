Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E697D1C4F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 11:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjJUJy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 05:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjJUJy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 05:54:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79AFDF
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 02:54:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328C9C433C8;
        Sat, 21 Oct 2023 09:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697882092;
        bh=RA9K1fGVTjS0IKGqX3NOaImRlEySMzvLyeKaUfb88qo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vvgBSlRpT7MpWvWslncuyQpwyyA9b9128lDlRRmAtRdAaosZ6SsTPwWCQ/KeDRjxM
         dcCicMiQm1GQYAhB+BjhaB56gSK3LjZEBpKdEGBtXROleiIYc+H+3L0Ef2Yh7jNLvZ
         VB1mzK87iCitGed47hERpxIlsdMOAh2xQu0oSulA=
Date:   Sat, 21 Oct 2023 11:54:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
Cc:     Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        Coiby Xu <coiby.xu@gmail.com>, netdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kumaran.4353@gmail.com
Subject: Re: [PATCH v2 0/2] staging: qlge: Replace the occurrences of (1<<x)
 by BIT(x)
Message-ID: <2023102122-ripcord-prune-8516@gregkh>
References: <cover.1697657604.git.nandhakumar.singaram@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697657604.git.nandhakumar.singaram@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 12:45:01PM -0700, Nandha Kumar Singaram wrote:
> This patchset performs code cleanup in qlge driver as per
> linux coding style and may be applied in any sequence.

Sorry, but this driver just got dropped entirely in my tree, see this
link for the details:
	https://lore.kernel.org/r/20231020124457.312449-1-benjamin.poirier@gmail.com
