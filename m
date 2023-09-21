Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D7C7A901B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 02:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjIUAOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 20:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjIUAOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 20:14:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DC0D7;
        Wed, 20 Sep 2023 17:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ibDOSSJo9iwIoGKgm8rWkWbkWGAjdN5Qgyomvt9ZVsQ=; b=QSE6DgWjudMhBAUtnW7ije77NR
        MMfMA4g+uM+IKRki8valXupHm+5aPeKZ1Z6ek3nj2vjy1B1F7xw9TIIdy2BN9r5BYMZD8utsM3TN0
        Fj+Z0P8Xqzp1jhO5wRM9rk0Yww4NkNhrDlwrfP/WG5JMvvrnu0kvvPG0MyhaKns+Xw432t9gcDJuU
        6PQI+jjx3cmubnxEi18AWscfuSoKCIehdTLlmb7P3I9zCR61JFPFULzbzsIIm/Pz0liaUtLV3SwqA
        MeC/4xLjNVhxzEjSfgoIa0V9R86NfZBhyonWuoGgu+CarEeHiLIRFJiTFkI9COPQsbXJO10JaekLf
        75cwZc+g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qj7LB-004Wey-0l;
        Thu, 21 Sep 2023 00:14:45 +0000
Date:   Wed, 20 Sep 2023 17:14:45 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     zhumao001@208suo.com
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: Fix comment typo
Message-ID: <ZQuK9VN/W/CdbvaK@bombadil.infradead.org>
References: <20230618143813.15142-1-dengshaomin@cdjrlc.com>
 <20230618143813.15142-6-dengshaomin@cdjrlc.com>
 <aef774d1ff3b260b46d5b81f61cdccfa@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aef774d1ff3b260b46d5b81f61cdccfa@208suo.com>
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

On Sun, Jun 18, 2023 at 10:58:43PM +0800, zhumao001@208suo.com wrote:
> 
> Delete duplicated word in comment.
> 
> Signed-off-by: Zhu Mao <zhumao001@208suo.com>
> ---

Applied and pushed, next time please consider sending a slew of typo
fixes, just one word is a bit too much trouble for just one patch.

  Luis
