Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9153768B70
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 07:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjGaF4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 01:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjGaF4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 01:56:12 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00761705
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 22:56:02 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B13E467373; Mon, 31 Jul 2023 07:55:59 +0200 (CEST)
Date:   Mon, 31 Jul 2023 07:55:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mark O'Donovan <shiftee@posteo.net>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, hch@lst.de, axboe@kernel.dk, kbusch@kernel.org,
        hare@suse.de
Subject: Re: [PATCH 1/2] nvme-auth: unlock mutex in one place only
Message-ID: <20230731055559.GA30150@lst.de>
References: <20230727134748.4163796-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727134748.4163796-1-shiftee@posteo.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
