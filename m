Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BA9793DED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 15:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241173AbjIFNoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 09:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjIFNoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 09:44:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A30CF1;
        Wed,  6 Sep 2023 06:44:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A297DC433C7;
        Wed,  6 Sep 2023 13:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694007853;
        bh=CsO1YYcv1agmiKj1lvn7Vyw9BRK3mJRnLWMt81bd6zE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jCrby6kqmYBZdvtcg893fAjXQG7kbAeelqwwsRWhntVdAb5XUetNC2lXET5xBcq9v
         AGUTnyb8DfydPnS1Bgw8eJa9ZbmcMnRNmeZUNyNp0o/ZF3yFw6dlTDVDltbr8OJeNH
         qz+IV+bF6KU6AmSk41ccahqmvxUIyWn51xPh+ASBq6lYiOCzzd8/YquayZ8S62sfNy
         4Wb+RJmOVuQuLEzElTivkei5lz2zK8dBT7cW0f2IZQLAogxQoCBaJJSWd45f9s6C/A
         46694S+W/vRNQHCJeV6ekkP8B82+D8DUKdqodD6m1y7uVlbyz3UzFJLzObsQJ+UPIm
         sVuH5jaPGgYHw==
Message-ID: <bfe9768b-a67e-170d-8130-c2e3cd6357a9@kernel.org>
Date:   Wed, 6 Sep 2023 15:44:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] tools/verification/dot2/dot2k: Delete duplicate imports
Content-Language: en-US, pt-BR, it-IT
To:     "Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230906103356.3916844-1-alessandro.carminati@gmail.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20230906103356.3916844-1-alessandro.carminati@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alessandro,

Do you mind changing the subject to:

verification/dot2k: Delete duplicate imports


On 9/6/23 12:33, Alessandro Carminati (Red Hat) wrote:
> The presence of duplicate import lines appears to be a typo.
> Removing them.
> 
> Signed-off-by: Alessandro Carminati (Red Hat) <alessandro.carminati@gmail.com>

and adding the Fixes: tag?

-- Daniel
