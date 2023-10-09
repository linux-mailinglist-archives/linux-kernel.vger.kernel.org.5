Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1BC7BE619
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377746AbjJIQQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377175AbjJIQQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:16:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7217B0;
        Mon,  9 Oct 2023 09:15:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A173C433C7;
        Mon,  9 Oct 2023 16:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696868158;
        bh=49CO1kvRSj0Odal4ZvqVDzekHuHM5gyCMEbzI8d6bpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pP8B+eF94tblZsTf2wnz26Vr2nITsTlPHaOH13jqnr07st2DEynZlk7D4AI0/W2cP
         ilV7j4JiepxzylfW6O7MynL1Ol9guzuxaT5cDTZfxjA/LTxF81yaB4cRIeiPi2lmfD
         XemKiDCTLUm/C2vM+GU68+B7IGEXUJWa8EI/gzJzap8YCCz93BG+fE0D7N3Ejnxugy
         WIEvoL1HotJv/Rc+RuIMZPrPeuqxszaEzspZikoFkvCexzZj+DgEtMpwxB9bsjp+SD
         eWRkcWvcJPP4mdRqzgJ2fF8SXeK/3EeYSJe/WgtqIlD9Su6AsBM9YJvXSb07GmvROd
         OxgqACOrs/JyQ==
Date:   Mon, 9 Oct 2023 18:15:53 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Sterba <dsterba@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the btrfs
 tree
Message-ID: <20231009-bauch-gedanken-e02e35804e03@brauner>
References: <20231009104840.1bdadc80@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009104840.1bdadc80@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I have dropped the vfs-brauner tree for today as there is no way I can
> sort them out in a reasonable time.  Please sort this out between
> yourselves.

I'll fix that up!
