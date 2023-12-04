Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075828034C6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235679AbjLDN1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbjLDN0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:26:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9642026A3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:24:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5524C433C7;
        Mon,  4 Dec 2023 13:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701696299;
        bh=tQWq1wkdhLsJDO4sSOf69mI0MINSzIOOUbI44WzQSqA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Vlc9Q3HV3+TEhCYdYe8AJaXz0nB269R1+GwWfkLoXgIFUC1BPoaAkN9qwhKgGJexj
         di7aLvBq8N1vYH5rnLmbuQgb+3KDf31V+L3SAlzjCUx6IisUsYa4vJekkpT57hb7+r
         czwk7KdHksXMeUslwUja4jKb5P4Gt2cBv2O9/DGlVud6rhc63X3MZ2auUQVGtKuE+s
         caT/LUYoyfl6HCqJYlBFz2JIDGfoCZN/m1XN/fQw6wVOzZnmwdhHunxteY3tunO8fk
         MKYYEma6Ds3t0zmxYBe+XvDb6wavtaq48CyYn3/1RsD9wQjWTqchbSwPoiLy3ZilHG
         kkBosByvv5PQA==
Date:   Mon, 4 Dec 2023 13:24:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Waqar Hameed <waqar.hameed@axis.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: proximity: irsd200: Drop unused include
Message-ID: <20231204132451.4d1790e1@jic23-huawei>
In-Reply-To: <pnd34woewec.fsf@axis.com>
References: <20231128-descriptors-iio-v1-1-da1e94755db6@linaro.org>
        <pnd34woewec.fsf@axis.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 10:31:26 +0100
Waqar Hameed <waqar.hameed@axis.com> wrote:

> On Tue, Nov 28, 2023 at 23:56 +0100 Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > The driver includes the legacy GPIO header <linux/gpio.h> but doesn't
> > use any symbols from it. Drop it.
> >
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>  
> 
> Reviewed-by: Waqar Hameed <waqar.hameed@axis.com>

Applied
