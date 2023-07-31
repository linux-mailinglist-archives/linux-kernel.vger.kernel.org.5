Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB2C76984A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbjGaNx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjGaNwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:52:23 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9051BC9;
        Mon, 31 Jul 2023 06:51:56 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E72F767373; Mon, 31 Jul 2023 15:51:52 +0200 (CEST)
Date:   Mon, 31 Jul 2023 15:51:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Mark O'Donovan <shiftee@posteo.net>,
        linux-nvme@lists.infradead.org, kernel-janitors@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] nvme-auth: unlock mutex in one place only
Message-ID: <20230731135152.GA6016@lst.de>
References: <20230727134748.4163796-1-shiftee@posteo.net> <28d11fc5-743f-0810-8ab7-3fa2a3f98c65@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28d11fc5-743f-0810-8ab7-3fa2a3f98c65@web.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 02:00:37PM +0200, Markus Elfring wrote:
> Are imperative change descriptions still preferred?

It doesn't fucking matter.  Please stop spamming nvme contributors.
