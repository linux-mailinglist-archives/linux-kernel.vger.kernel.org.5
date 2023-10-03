Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B597B5E49
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 02:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238205AbjJCAfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 20:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238700AbjJCAfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 20:35:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2548FD;
        Mon,  2 Oct 2023 17:34:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F10C433AB;
        Tue,  3 Oct 2023 00:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696293293;
        bh=p6qznuAAZAoVYgv+yLDynMUW18PfarM3W+3DEN8LiZM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tXd812b+8N7UHHGjNi5N9CJZSBsgKg98xPHAFvLv9vlFPZmA6ZU6Tae9+8d754m+L
         BGcH+1CH4KcIleBHl1T6r/u5sCMb+ToJ9cL8GrfGlmsCmhaRA7+0OwK+0N/URh2W9V
         D4h7b6wrNVH6riW78xxPo9QBzzlEj2mJvVoBv+g7Ydkad4MUil/9FfkN0bc4d75AfK
         hAgFGSBScloRfzDSOEmzYInjO9C59dM+pC8+jfVDphRy7kU/ug6rOuws5JMSruHIZB
         pEL7VUz/YbmmkKH22TEeEx6STJZai90ZSXP6iGB2VLTUWL/3X+xbWI3nm2M0oaT4ZW
         Ys4O9gmTvPU+g==
Message-ID: <3c9e7243-f95f-9796-7e73-5e7a9ca16db3@kernel.org>
Date:   Tue, 3 Oct 2023 09:34:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/4] pata_parport: fix EXP Computer CD-865 with MC-1285B
 EPP cable
Content-Language: en-US
To:     Ondrej Zary <linux@zary.sk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230930191511.24994-1-linux@zary.sk>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230930191511.24994-1-linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/23 04:15, Ondrej Zary wrote:
> 
> Two bugfixes, one workaround and IDE command set registers support for fit3
> driver. All needed for EXP Computer CD-865 drive with MC-1285B EPP cable to
> work.
> 

Please use my email address listed by get_maintainer.pl: dlemoal@kernel.org

And these patches do not involve linux-block and Jens, so no need to send there
(that reduces noise on the block list).

-- 
Damien Le Moal
Western Digital Research

