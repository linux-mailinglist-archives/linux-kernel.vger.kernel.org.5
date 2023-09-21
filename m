Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B6A7A9013
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 02:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjIUAKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 20:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjIUAKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 20:10:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AB2DE;
        Wed, 20 Sep 2023 17:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uzMWWwMSWrH9ScNUhJ+coV/p5G7E1kUlCFK74P78O3A=; b=H1Ks8o5x9ZSmzt4PeTJtJzkfGw
        cEl1BVs2eg2/4150M1yBJLaxhhxSgchP5GhFZkSSaKL3K7hJYfeNGu+mqBeH9gt4GokqqGFDpj7gz
        37x90szNfRext89773xbxRpHTuwOD33YhtAItpZlDPgOMErNICR5JIEvbgeKSYXl4pC8dgBzUvjmo
        UIfmVBE6xasR+E1e2mPsq7cum11Rm6pUR/JbMBtb8aQA4wO42YvPxNvHf/kSdG7tpoAZ2N4Y8xbLJ
        D9Z49LOvhx1xGVUEZy/UICYv+CXvIhIYMco7UwS53AzFMTuCJEyZI2dyjr32uyYP2JGyRv606bidF
        tbdhQKQw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qj7HA-004WKb-08;
        Thu, 21 Sep 2023 00:10:36 +0000
Date:   Wed, 20 Sep 2023 17:10:35 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH 0/2] module: Do some small changes
Message-ID: <ZQuJ+zSf/IYQ3HwA@bombadil.infradead.org>
References: <1686880293-29594-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1686880293-29594-1-git-send-email-yangtiezhu@loongson.cn>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 09:51:31AM +0800, Tiezhu Yang wrote:
> The first patch is suggested by Xi Zhang <zhangxi@kylinos.cn> offline,
> the second patch is inspired by the first patch, no functional changes.

Applied and pushed, thanks!

  Luis
