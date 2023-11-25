Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DC57F8CC7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 18:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjKYR3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 12:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjKYR3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 12:29:17 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B7A127
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 09:29:22 -0800 (PST)
Received: from mail.denx.de (unknown [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 8002787158;
        Sat, 25 Nov 2023 18:29:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1700933360;
        bh=RlwM36/Eve0Vl6Dwjb1bhH2vCr+F58ntQbNm9SP0wRQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T+Z5s3EsjXnkrcqyyXeMRs5SJPqrMV+Yk2O1t5ddOGH5wYVyeGhPksXqBdS+35Fzs
         EJ8qPthUyrBQKgUkds5B4HZSM1GbbXKsJP3N/J0YD+nC9W3yy6GObARlVv3g4gLqi4
         yQJFGD89fVdpO/Etr4Z4e0Ny8D5S5vJ5to6juXuYkgwIYoKfquA0ptsTvCZXqix1z5
         bGBamaAANiQTfEpuHA8+SoERdeqRYp44sZtUfRm1CX1aJEuTAO6LnOjygi+m3D/wRd
         pXY42uenJnkBx38bpmvArqBGEOOhxRPNgsCZ9n1CUUISGoH5WfeOQ1VRWU1Kn/bgTJ
         F9zSpcMSXpLHQ==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 25 Nov 2023 14:29:20 -0300
From:   Fabio Estevam <festevam@denx.de>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     pratyush@kernel.org, michael@walle.cc,
        linux-mtd@lists.infradead.org, takahiro.kuwano@infineon.com,
        bacem.daassi@infineon.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] mtd: spi-nor: introduce die erase
In-Reply-To: <d7ce98eb-c920-413f-bbe9-059077a9dda7@linaro.org>
References: <20231125123529.55686-1-tudor.ambarus@linaro.org>
 <d7ce98eb-c920-413f-bbe9-059077a9dda7@linaro.org>
Message-ID: <6156a51f7eadc9594404bb0eacabe1a6@denx.de>
X-Sender: festevam@denx.de
User-Agent: Roundcube Webmail/1.3.6
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

On 25/11/2023 09:37, Tudor Ambarus wrote:
> I made a typo on Fabio's email address. Now added correctly.

It looks like the Subject of patch 3/5 is not complete:

[PATCH v3 3/5] mtd: spi-nor: micron-st: "

Feel free to add to this series:

Tested-by: Fabio Estevam <festevam@denx.de>
