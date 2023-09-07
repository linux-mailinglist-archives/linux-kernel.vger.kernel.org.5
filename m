Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0867779736F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbjIGPYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjIGPXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:23:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B45FE6B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:22:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1454CC43395;
        Thu,  7 Sep 2023 08:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694074483;
        bh=OCuI7TmziokJl+2qmcXoAZYq+Z4TxTENE+xPQbRlpe4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T+8XOhDhwD7p0xPIzG3ezpJZO97yux9KetgNiwIoOGm87MpiCf5Mi/aw0sL9tq3yV
         qkTttaL7MqnqKlnlhPb0f+NdQpmdYDoyhR7PYaPa7dOUbNZumdKvoXhNwzuwN0UEdv
         FprJGaBHgR4k2rjWLIPoXZ/UVtuDOb8VBv+YD8zaLH/L6CaggHv0Lv9tVTMKl9sW9T
         xMqiJEpmVH8L/YHNfsHOa+nI6pFUL3AQyZouS9Tr3ItVOfPsShvO4qrvHEt9mqUqrj
         P6vdX70Us2dFsxQvxBa+KOi+i03OrOcF2yJS/QXN+3GaRdJc03cO38cLVpba4i1qGL
         DZ8Zz5N8sFmtg==
MIME-Version: 1.0
Date:   Thu, 07 Sep 2023 10:14:39 +0200
From:   Michael Walle <mwalle@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 39/41] mtd: spi-nor: winbond: sort flash_info entries
In-Reply-To: <eec52fd8-663d-7e56-3627-2b33259027b6@linaro.org>
References: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
 <20230807-mtd-flash-info-db-rework-v2-39-291a0f39f8d8@kernel.org>
 <eec52fd8-663d-7e56-3627-2b33259027b6@linaro.org>
Message-ID: <c55604322b8b5bb74ce293885599810c@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm fine with the sorting by ID.
> 
> 
> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Also here, should I convert this to an Acked-by: for all the
sorting patches?

-michael
