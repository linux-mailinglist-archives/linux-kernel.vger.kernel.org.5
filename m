Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD587CEEE1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 07:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjJSFC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 01:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJSFCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 01:02:54 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CC2114
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 22:02:53 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9BBF967373; Thu, 19 Oct 2023 07:02:49 +0200 (CEST)
Date:   Thu, 19 Oct 2023 07:02:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     james.smart@broadcom.com, hch@lst.de, sagi@grimberg.me,
        kch@nvidia.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] nvmet-fc: Remove unused function
Message-ID: <20231019050249.GB13957@lst.de>
References: <20231019025611.30228-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019025611.30228-1-jiapeng.chong@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

