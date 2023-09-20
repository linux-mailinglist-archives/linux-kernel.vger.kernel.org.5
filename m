Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CDB7A7D85
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbjITMKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235499AbjITMJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:09:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AE7C2;
        Wed, 20 Sep 2023 05:09:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27683C433C9;
        Wed, 20 Sep 2023 12:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695211791;
        bh=G2OC3NgDES45apW6LPDhKBFEV8WH2ofKiegBWduU/5Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rut7PB2K7XdbeC7fps0XMFSLWgmFKqC27koEB34RmIjg2m0FC3MgSg1/gd6SLw5gW
         C+/EcKNbVXih6G6eeO6HprhW/g/z7xz/vJVPN2nnWP82ykRwQ1NjytP5mISYvA/4wR
         7sAfqR7//cRuQgyzaNEzAuOJeCm4Fw2g1uxwGUoF/sr6ErrqVpGqeEBaaSp+8b0kSF
         rKSxjYzZ/Zo1tq/ZtEU+hUKnaFAAVydxjkZGrcBK9Eve6HWd56wvGMHECq1t79ZEuT
         8YVv/WtmCYh6ULaIJXCTvoIH7bFMrm7mnCGABuVXsNZ671ksPqSh2nqiTpI8zPqRZA
         xXe5nqPj0Q1aQ==
Date:   Wed, 20 Sep 2023 14:09:47 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the vfs-brauner tree
Message-ID: <20230920-fauna-klammheimlich-34efbe7fa594@brauner>
References: <20230915093953.310503ee@canb.auug.org.au>
 <20230918205206.GA348037@frogsfrogsfrogs>
 <20230919-zensieren-plakat-05a044361e57@brauner>
 <20230919154334.GD348037@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230919154334.GD348037@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'll push that patch, then.

Ok, dropping.
