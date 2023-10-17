Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856767CCE06
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjJQU2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJQU2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:28:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B482892
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:28:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3867C433C7;
        Tue, 17 Oct 2023 20:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697574486;
        bh=DnekdBLvdBZ3/BD0lTuUjyIhhw4YnWgK3yI8P0+hlBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Go4zkLBrn4oUzaC3J+jxXiiFFz7hXXSrzo2EuKcknHkHncHb9bK4mJi7qdAfcaVyR
         VvmrG2nD1greb2DKA5ove1jpQNwLZScvLaFj+12UC/86mWiZe2or9838J5mxcOBIQs
         r7i5ypkK2i4DAeve/kOOxLjgInkfkQidPao7aV1yDuBEaXG81imy7HXbWxCviLgRml
         FEV7bXgh+dA3Mx4pd1xK9YOOeRt0mDwWD+pj5ByjOIGxq6bAjHUDxGFntd82QvThY8
         fSBTvEAYVDa1AHye5/4gabUkxz6iOwnyQZoNsLD68cJRKyDQCExYkkdk8paIqadr5Y
         cuXtKQYrGTbQQ==
Date:   Tue, 17 Oct 2023 14:28:03 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Mark O'Donovan <shiftee@posteo.net>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, hch@lst.de, axboe@kernel.dk, hare@suse.de
Subject: Re: [PATCH v5 0/3] Remove secret-size restrictions for hashes
Message-ID: <ZS7uU9GFtFSKIeJ-@kbusch-mbp>
References: <20231017170919.30358-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017170919.30358-1-shiftee@posteo.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued up for nvme-6.7, thanks!
