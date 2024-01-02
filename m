Return-Path: <linux-kernel+bounces-14813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFC88222BE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F821B221AE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 20:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF2C16424;
	Tue,  2 Jan 2024 20:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="DaH0KB+5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2113168A4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 20:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 To: Subject: MIME-Version: Date: Message-ID; q=dns/txt; s=fe-e1b5cab7be;
 t=1704228988; bh=ccZgqPCrJ4T9GeS8WnNP4L0gon1xZyOTx7zhUGDzNNc=;
 b=DaH0KB+5QYKAOAnRy5h6rDe5fjTgNdsmF4lFOcqxdsv3vpukMlnHOv9ESNFhq+KfIwTeEKjXk
 2e0KzMSn/FK6IZOrohCBq/jCd4TuUYAG9537LgfPP+JlRDIicnd0BEfneaXY3FbPeGGH5G3uPT3
 PWqOEyLrX/S5lF8VUuLcQRWjen8bSmSxMlTH/cBvzOGFx+lXlK5Y8DkoIRrCyyNhD744o4kIY/K
 56xbC4S1K5Ay/0LwhOpghd94srR0A79K/xSildlCid/akMIkCE1rD3e+MpoiaJL94eRnmWvq4aL
 0vADC7dkPJOL8y3mshEqBZdKpAphrV424solT5lwvJlQ==
Message-ID: <903e9d0c-a00c-4214-9f0e-dd676b13b428@kwiboo.se>
Date: Tue, 2 Jan 2024 21:56:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] arm64: dts: rockchip: Add devicetree for Pine64
 PineTab2
Content-Language: en-US
To: "=?UTF-8?Q?Ond=C5=99ej_Jirman?=" <megi@xff.cz>, Manuel Traut
 <manut@mecka.net>, Neil Armstrong <neil.armstrong@linaro.org>, Jessica
 Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>, Mark
 Yao <markyao0591@gmail.com>, Diederik de Haas <didi.debian@cknow.org>,
 Segfault <awarnecke002@hotmail.com>, Arnaud Ferraris
 <aferraris@debian.org>, Danct12 <danct12@riseup.net>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20240102-pinetab2-v3-0-cb1aa69f8c30@mecka.net>
 <20240102-pinetab2-v3-4-cb1aa69f8c30@mecka.net>
 <775vjfucu2g2s6zzeutj7f7tapx3q2geccpxvv4ppcms4hxbq7@cbrdmlu2ryzp>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <775vjfucu2g2s6zzeutj7f7tapx3q2geccpxvv4ppcms4hxbq7@cbrdmlu2ryzp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6594787c1cdb56bea851e248

Hi Manuel and Ondřej,

On 2024-01-02 19:07, Ondřej Jirman wrote:
> Hello Manuel,

[...]

>> +
>> +&sfc {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&fspi_dual_io_pins>;
>> +	status = "okay";
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +
>> +	flash@0 {
>> +		compatible = "jedec,spi-nor";
>> +		reg = <0>;
>> +		spi-max-frequency = <24000000>;
> 
> That's a bit on the low side. The flash chip should work for all commands up to
> 80MHz https://megous.com/dl/tmp/b428ad9b85ac4633.png and SGM3157YC6 switch
> for the FSPI-CLK should have high enough bandwidth, too.

I agree that this is a little bit on the low side, it was a safe rate
that I used for U-Boot. U-Boot required an exact rate of the supported
sfc clk rates: 24, 50, 75, 100, 125 or 150 MHz.

Please also note that the SPI NOR flash chip used in PineTab2 is not a
GigaDevice GD25LQ128E, it should be a SiliconKaiser SK25LP128, same as
found in the Pine64 PinePhone Pro.

> 
>> +		spi-rx-bus-width = <2>;
> 
> GD25LQ128E supports quad I/O. Maybe try 4 if it will work.

The schematic only shows fspi D0 and D1 connected, and use the D2 line
for eMMC_RSTn, so spi-rx-bus-width = <2> should be correct.

> 
>> +		spi-tx-bus-width = <1>;
>> +	};
>> +};
>> +

Regards,
Jonas

