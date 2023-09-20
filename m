Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092037A886F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236524AbjITPcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbjITPcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:32:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302A98F;
        Wed, 20 Sep 2023 08:32:38 -0700 (PDT)
Received: from localhost (89-26-75-29.dyn.cablelink.at [89.26.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6BAAD66003AC;
        Wed, 20 Sep 2023 16:32:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695223957;
        bh=4IJaZ1yvgFVvsiuWU2ttAjJn7mIhMhRbw+6+t/h4UCk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N08yr99zY8rH2yALg3mXmTFuNnIKtzz6voWUe9WefldqLm/j3gxt8U72A/7p41dbL
         fb/ByhTfk1SqhM+i5E+uwyUBF7fRqGUKOHmTPgG6y4RqmaHEsXT2juJf9hL21a0RZ8
         iTKi2ABy7s8dxNB9CGuWJeEYg4V/MMv0qHIVP8NA8todvphQxmsMqmk2vWxRrDiPU4
         yMcVszEBPCt8paD2ypl0OMr+uwwPYUXHq7+DmSYFFvNBijL9OjnhbkSVINB2Ix4QN2
         HJ2RqUwif3Wc5LTEUvs4XtZNeo/3R84VDt82wLs1sjNEMBjUa4iYCh9z2bej1NfGqP
         S8/H8nT7+faFA==
Date:   Wed, 20 Sep 2023 17:32:34 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nas Chung <nas.chung@chipsnmedia.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Robert Beckett <bob.beckett@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Subject: Re: [PATCH v12 7/7] media: chips-media: wave5: Add wave5 driver to
 maintainers file
Message-ID: <20230920153234.3x3obpt355hhdyz6@basti-XPS-13-9310>
References: <20230915-wave5_v12_on_media_master-v12-0-92fc66cd685d@collabora.com>
 <20230915-wave5_v12_on_media_master-v12-7-92fc66cd685d@collabora.com>
 <2e1aebf4-090a-4966-bbe0-a6c41d9f97ba@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <2e1aebf4-090a-4966-bbe0-a6c41d9f97ba@xs4all.nl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Hans,

thanks for your review on our driver.

On 20.09.2023 15:02, Hans Verkuil wrote:
>On 15/09/2023 23:11, Sebastian Fricke wrote:
>> From: Robert Beckett <bob.beckett@collabora.com>
>>
>> Add the Chips&Media wave5 encoder/decoder driver to the maintainers file
>>
>> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
>> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
>> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
>> ---
>>  MAINTAINERS | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 063a11791bbf..b6a592c14caa 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -23206,6 +23206,14 @@ F:	include/linux/watchdog.h
>>  F:	include/trace/events/watchdog.h
>>  F:	include/uapi/linux/watchdog.h
>>
>> +WAVE5 VPU CODEC DRIVER
>> +M:	Nas Chung <nas.chung@chipsnmedia.com>
>> +M:	Jackson Lee <jackson.lee@chipsnmedia.com>
>
>Hmm, is this right? Shouldn't Sebastian be added here? Or is it really
>intended that once this driver is merged, any maintenance will be done
>by Chips&Media people?
>
>Just checking if this is intended.

Yes, this is communicated with Chips & Media, they want to take full
responsibility for the maintenance.

>
>Regards,
>
>	Hans

Sincerely,
Sebastian

>
>> +L:	linux-media@vger.kernel.org
>> +S:	Maintained
>> +F:	Documentation/devicetree/bindings/media/cnm,wave5.yaml
>> +F:	drivers/media/platform/chips-media/wave5/
>> +
>>  WHISKEYCOVE PMIC GPIO DRIVER
>>  M:	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>  L:	linux-gpio@vger.kernel.org
>>
>
>_______________________________________________
>Kernel mailing list -- kernel@mailman.collabora.com
>To unsubscribe send an email to kernel-leave@mailman.collabora.com
