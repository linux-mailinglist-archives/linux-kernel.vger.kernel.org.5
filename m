Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4627D47B7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 08:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbjJXGuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 02:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbjJXGuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 02:50:02 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A268D78
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 23:50:00 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C67806732D; Tue, 24 Oct 2023 08:49:57 +0200 (CEST)
Date:   Tue, 24 Oct 2023 08:49:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mark O'Donovan <shiftee@posteo.net>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, hch@lst.de, axboe@kernel.dk, kbusch@kernel.org,
        hare@suse.de
Subject: Re: [PATCH v2 3/3] nvme-auth: always set valid seq_num in dhchap
 reply
Message-ID: <20231024064957.GC9847@lst.de>
References: <20231023140003.58019-1-shiftee@posteo.net> <20231023140003.58019-4-shiftee@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023140003.58019-4-shiftee@posteo.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
